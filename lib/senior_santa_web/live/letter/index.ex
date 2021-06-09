defmodule SeniorSantaWeb.LetterLive.Index do
  use SeniorSantaWeb, :live_view
  alias FE.Result

  alias SeniorSanta.Reservations.Services

  @impl true
  def mount(params, _session, socket) do
    params
    |> Map.get("location", "Warszawa")
    |> Services.Letter.get_all_by_location()
    |> Result.map(fn letters ->
      socket
      |> assign(:letters, letters)
      |> assign(:letter, List.first(letters))
      |> assign(
        :reservation,
        Ecto.Changeset.change(%SeniorSanta.Reservations.IO.Schemas.Letter{})
      )
    end)
  end

  @impl true
  def handle_event("select", %{"letter_id" => letter_id}, socket) do
    {:ok, letter} = Services.Letter.get(letter_id)
    {:noreply, assign(socket, :letter, letter)}
  end

  @impl true
  def handle_event("validate", params, socket) do
    IO.inspect("validate")
    IO.inspect(params)
    {:noreply, socket}
  end

  @impl true
  def handle_event("save", params, socket) do
    IO.inspect("save")
    IO.inspect(params)
    {:noreply, socket}
  end
end
