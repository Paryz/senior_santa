defmodule SeniorSanta.Reservations.IO.User do
  alias FE.{Maybe, Result}

  alias SeniorSanta.Repo

  alias SeniorSanta.Reservations.IO.Schemas
  alias SeniorSanta.Reservations.Models

  @spec create(Models.User.t()) :: Result.t(Models.User.t())
  def create(%Models.User{} = user) do
    %Schemas.User{}
    |> Ecto.Changeset.change(drop_keys_with_nothing(user))
    |> Repo.insert()
    |> Result.and_then(&Models.User.new/1)
  end

  def create(_), do: Result.error(:conflict)

  defp drop_keys_with_nothing(user) do
    user
    |> Map.from_struct()
    |> Enum.filter(fn {_k, v} -> v != Maybe.nothing() end)
  end
end
