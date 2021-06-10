defmodule SeniorSanta.Reservations.IO.User do
  alias FE.Result

  alias SeniorSanta.Repo

  alias SeniorSanta.Reservations.IO.Schemas
  alias SeniorSanta.Reservations.Models

  @spec create(Models.User.t()) :: Result.t(Models.User.t())
  def create(%Models.User{} = user) do
    %Schemas.User{id: Ecto.UUID.generate()}
    |> Ecto.Changeset.change(Map.from_struct(user))
    |> Repo.insert()
    |> Result.map(fn _ -> user end)
  end

  def create(_), do: Result.error(:conflict)
end
