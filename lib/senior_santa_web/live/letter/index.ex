defmodule SeniorSantaWeb.LetterLive.Index do
  use SeniorSantaWeb, :live_view
  use Phoenix.Component
  alias FE.Result

  alias SeniorSantaWeb.Components.Letter
  alias SeniorSanta.Reservations.Services

  def topic(), do: inspect(__MODULE__)

  def render(assigns) do
    ~H"""
    <section>
      <div class="flex flex-row text-center">
        <Letter.List.render letters={@letters} letter={@letter} letter_blocker={@letter_blocker} socket_id={@socket_id} />
        <%= if not is_nil(@letter) do %>
          <Letter.Detail.render letter={@letter} reservation={@reservation} letter_blocker={@letter_blocker} socket_id={@socket_id} />
        <% end %>
      </div>
    </section>
    """
  end

  def mount(params, _session, socket) do
    subscribe()

    params
    |> fetch_all_letters()
    |> Result.map(fn letters ->
      socket
      |> assign(:socket_id, socket.id)
      |> assign(:letters, letters)
      |> assign(:letter, List.first(letters))
      |> assign(:letter_blocker, Services.LetterBlocker.get_state())
      |> assign(
        :reservation,
        Ecto.Changeset.change(%SeniorSanta.Reservations.IO.Schemas.Reservation{})
      )
    end)
  end

  def handle_event("select", %{"letter_id" => letter_id}, socket) do
    {:ok, letter} = Services.Letter.get(letter_id)
    {:noreply, assign(socket, :letter, letter)}
  end

  def handle_event("block", %{"letter_id" => letter_id}, socket) do
    Services.LetterBlocker.block(letter_id, socket.id)
    broadcast(:letter_blocker, [:letter_blocker, :updated])
    {:noreply, socket}
  end

  def handle_event("unblock", %{"letter_id" => letter_id}, socket) do
    Services.LetterBlocker.unblock(letter_id, socket.id)
    broadcast(:letter_blocker, [:letter_blocker, :updated])
    {:noreply, socket}
  end

  def handle_event("save", %{"reservation" => params}, socket) do
    handle_event("unblock", params, socket)

    with {:ok, _letter} <- Services.Letter.reserve(params) do
      broadcast(:letter, [:letter, :updated])
      {:noreply, socket}
    end
  end

  def handle_info({SeniorSantaWeb.LetterLive.Index, [:letter, _], _}, socket) do
    with {:ok, letters} <- fetch_all_letters(%{"location" => socket.assigns[:letter].location}) do
      socket
      |> assign(:letters, letters)
      |> assign(:letter, List.first(letters))
      |> then(&{:noreply, &1})
    end
  end

  def handle_info({SeniorSantaWeb.LetterLive.Index, [:letter_blocker, :deleted], _}, socket) do
    socket
    |> assign(:letter_blocker, Services.LetterBlocker.get_state())
    |> then(&{:noreply, &1})
  end

  def handle_info({SeniorSantaWeb.LetterLive.Index, [:letter_blocker, _], _}, socket) do
    {:noreply, assign(socket, :letter_blocker, Services.LetterBlocker.get_state())}
  end

  def terminate(_reason, socket) do
    Services.LetterBlocker.unblock_all_user_timers(socket.id)
  end

  defp fetch_all_letters(params) do
    params
    |> Map.get("location", "Warszawa")
    |> Services.Letter.get_all_by_location()
  end

  defp subscribe() do
    Phoenix.PubSub.subscribe(SeniorSanta.PubSub, topic())
  end

  defp broadcast(result, event) do
    Phoenix.PubSub.broadcast(SeniorSanta.PubSub, topic(), {__MODULE__, event, result})
  end
end
