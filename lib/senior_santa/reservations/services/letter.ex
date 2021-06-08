defmodule SeniorSanta.Reservations.Services.Letter do
  alias FE.Maybe

  alias SeniorSanta.Reservations.IO

  defdelegate get_all_by_location(location), to: IO.Letters

  def get(id), do: id |> IO.Letters.get() |> Maybe.to_result(:not_found)
end
