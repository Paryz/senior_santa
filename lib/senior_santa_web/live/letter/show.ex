defmodule SeniorSantaWeb.LetterLive.Show do
  use SeniorSantaWeb, :live_view
  alias FE.Result

  alias SeniorSanta.Reservations.Services

  @impl true
  def mount(params, _session, socket) do
    params
    |> Map.get("letter_id", Ecto.UUID.generate())
    |> Services.Letter.get()
    |> Result.map(&assign(socket, :letter, &1))
  end
end
