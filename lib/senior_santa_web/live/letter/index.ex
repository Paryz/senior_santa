defmodule SeniorSantaWeb.LetterLive.Index do
  use SeniorSantaWeb, :live_view

  alias SeniorSanta.Models.Letter

  @impl true
  def mount(params, _session, socket) do
    city = Map.get(params, "city", "Warszawa")
    {:ok, assign(socket, :letters, find_letters(city))}
  end

  defp find_letters(city) do
    [
      %Letter{
        id: 1,
        author: "Janina",
        content: "file",
        currently_watching: 4,
        location: "Warszawa",
        status: "aktywny"
      },
      %Letter{
        id: 2,
        author: "Barbara",
        content: "file",
        currently_watching: 0,
        location: "Warszawa",
        status: "zarezerwowany"
      },
      %Letter{
        id: 3,
        author: "Anna",
        content: "file",
        currently_watching: 5,
        location: "Warszawa",
        status: "aktywny"
      }
    ]
    |> Enum.filter(&(&1.location == city))
  end
end
