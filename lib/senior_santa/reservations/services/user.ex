defmodule SeniorSanta.Reservations.Services.User do
  alias FE.Result

  alias SeniorSanta.Reservations.IO.User
  alias SeniorSanta.Reservations.Models

  @spec validate(map()) :: Result.t(Models.User.t())
  def validate(params) do
    Models.User.new(params)
  end

  @spec create(map()) :: Result.t(Models.User.t())
  def create(params) do
    params
    |> Models.User.new()
    |> Result.and_then(&User.create/1)
  end
end
