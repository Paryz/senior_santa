defmodule SeniorSanta.Reservations.Services.Letter do
  alias SeniorSanta.Reservations.IO

  defdelegate get_all_by_location(location), to: IO.Letter

  def get(id), do: IO.Letter.get(id)

  def reserve(params), do: IO.Letter.reserve(params)
end
