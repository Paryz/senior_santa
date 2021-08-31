defmodule SeniorSantaWeb.LetterLive.Index do
  use SeniorSantaWeb, :live_view
  use Phoenix.Component
  alias FE.Result

  alias SeniorSantaWeb.Components.Letter
  alias SeniorSanta.Reservations.Services

  def render(assigns) do
    ~H"""
    <section>
      <div class="flex flex-row text-center">
        <Letter.List.render letters={@letters} letter={@letter} />
        <%= if not is_nil(@letter) do %>
          <Letter.Detail.render letter={@letter} reservation={@reservation} />
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
      |> assign(:letters, letters)
      |> assign(:letter, List.first(letters))
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

  def handle_event("save", %{"reservation" => params}, socket) do
    with {:ok, letter} <- Services.Letter.reserve(params) do
      broadcast(letter, [:letter, :updated])
      {:noreply, assign(socket, :letter, letter)}
    end
  end

  def handle_info({SeniorSantaWeb.LetterLive.Index, [:letter, _], _}, socket) do
    with {:ok, letters} <- fetch_all_letters(%{"location" => socket.assigns[:letter].location}) do
      {:noreply, assign(socket, :letters, letters)}
    end
  end

  defp fetch_all_letters(params) do
    params
    |> Map.get("location", "Warszawa")
    |> Services.Letter.get_all_by_location()
  end

  @topic inspect(__MODULE__)
  defp subscribe() do
    Phoenix.PubSub.subscribe(SeniorSanta.PubSub, @topic)
  end

  defp broadcast(result, event) do
    Phoenix.PubSub.broadcast(SeniorSanta.PubSub, @topic, {__MODULE__, event, result})
  end
end
