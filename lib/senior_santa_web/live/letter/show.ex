defmodule SeniorSantaWeb.LetterLive.Show do
  use SeniorSantaWeb, :live_view

  alias SeniorSanta.Reservations.Models.Letter

  @impl true
  def mount(params, _session, socket) do
    IO.inspect(params)
    {:ok, assign(socket, :letter, letter())}
  end

  defp letter() do
    %Letter{
      author: "Janina",
      content: "file",
      currently_watching: 4,
      location: "Warszawa",
      status: "aktywny"
    }
  end
end
