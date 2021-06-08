defmodule SeniorSanta.Reservations.IO.Letters do
  import Ecto.Query
  alias FE.Result

  alias SeniorSanta.Repo

  alias SeniorSanta.Reservations.IO.Schemas
  alias SeniorSanta.Reservations.Models

  @spec get_all_by_location(String.t()) :: Result.t(Models.Letter.t())
  def get_all_by_location(location) do
    Schemas.Letter
    |> where(location: ^location)
    |> Repo.all()
    |> Enum.map(fn letter -> letter |> Models.Letter.new() |> Result.unwrap!() end)
    |> Result.ok()
  end
end
