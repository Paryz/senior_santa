defmodule SeniorSantaWeb.PageLive do
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
        author: "Janina",
        content: "file",
        currently_watching: 4,
        location: "Warszawa",
        status: "aktywny"
      },
      %Letter{
        author: "Barbara",
        content: "file",
        currently_watching: 0,
        location: "Warszawa",
        status: "zarezerwowany"
      },
      %Letter{
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
