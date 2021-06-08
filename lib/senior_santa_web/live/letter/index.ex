defmodule SeniorSantaWeb.LetterLive.Index do
  use SeniorSantaWeb, :live_view
  alias FE.Result

  alias SeniorSanta.Reservations.Services

  @impl true
  def mount(params, _session, socket) do
    params
    |> Map.get("location", "Warszawa")
    |> Services.Letter.get_all_by_location()
    |> Result.map(&assign(socket, :letters, &1))
  end
end
