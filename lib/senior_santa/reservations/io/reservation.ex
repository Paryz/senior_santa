defmodule SeniorSanta.Reservations.IO.Reservation do
  alias FE.{Maybe, Result}

  alias SeniorSanta.Repo

  alias SeniorSanta.Reservations.IO.Schemas
  alias SeniorSanta.Reservations.Models

  @spec create(Models.Reservation.t()) :: Result.t(Models.Reservation.t())
  def create(%Models.Reservation{} = reservation) do
    %Schemas.Reservation{}
    |> Ecto.Changeset.change(drop_keys_with_nothing(reservation))
    |> Repo.insert()
    |> Result.and_then(&Models.Reservation.new/1)
  end

  def create(_), do: Error.domain(:bad_request) |> Result.error()

  defp drop_keys_with_nothing(reservation) do
    reservation
    |> Map.from_struct()
    |> Enum.filter(fn {_k, v} -> v != Maybe.nothing() end)
  end
end
