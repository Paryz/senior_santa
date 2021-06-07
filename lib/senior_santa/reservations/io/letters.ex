defmodule SeniorSanta.Reservations.IO.Letters do
  import Ecto.Query
  alias FE.Result

  alias SeniorSanta.Repo

  alias SeniorSanta.Reservations.IO.Schemas
  alias SeniorSanta.Reservations.Models

  @spec get_all_by_location(keyword()) :: Result.t(Models.Letter.t())
  def get_all_by_location(list) do
    Schemas.Letter
    |> where(^list)
    |> Repo.all()
    |> Enum.map(&Models.Letter.new/1)
    |> Enum.map(&Result.unwrap!(&1))
    |> Result.ok()
  end
end
