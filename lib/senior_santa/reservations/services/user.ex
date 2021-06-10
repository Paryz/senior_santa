defmodule SeniorSanta.Reservations.Services.User do
  alias FE.Result

  alias SeniorSanta.Reservations.IO.User
  alias SeniorSanta.Reservations.Models

  @spec create(map()) :: Result.t(Models.User.t())
  def create(params) do
    params
    |> add_uuid_and_atomize_keys()
    |> Result.and_then(&Models.User.new/1)
    |> Result.and_then(&User.create/1)
  end

  defp add_uuid_and_atomize_keys(params) do
    params
    |> Map.delete("id")
    |> Map.put("id", Ecto.UUID.generate())
    |> Data.Enum.atomize_keys!(safe: true)
    |> Result.ok()
  end
end
