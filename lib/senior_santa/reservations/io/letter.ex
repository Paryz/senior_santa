defmodule SeniorSanta.Reservations.IO.Letter do
  import Ecto.Query, only: [where: 2]
  alias Ecto.Multi

  alias FE.Result

  alias SeniorSanta.Repo

  alias SeniorSanta.Reservations.IO, as: IOs
  alias SeniorSanta.Reservations.IO.Schemas
  alias SeniorSanta.Reservations.Models

  @spec get_all_by_location(String.t()) :: Result.t([Models.Letter.t()])
  def get_all_by_location(location) do
    Schemas.Letter
    |> where(location: ^location)
    |> where(status: :active)
    |> Repo.all()
    |> Enum.map(fn letter -> letter |> Models.Letter.new() |> Result.unwrap!() end)
    |> Result.ok()
  end

  @spec get(binary()) :: Result.t(Models.Letter.t())
  def get(id) do
    Schemas.Letter
    |> Repo.get(id)
    |> case do
      nil -> Error.domain(:letter_not_found) |> Result.error()
      letter -> Models.Letter.new(letter)
    end
  end

  @spec reserve(map()) :: Result.t(Models.Reservation.t())
  def reserve(params) do
    Multi.new()
    |> Multi.run(:get_letter, fn _, _ -> get(params["letter_id"]) end)
    |> Multi.run(:create_user, fn _, _ ->
      params
      |> Models.User.new()
      |> Result.and_then(&IOs.User.create/1)
    end)
    |> Multi.run(:create_reservation, fn _, %{create_user: user} ->
      params
      |> Map.put("user_id", FE.Maybe.unwrap!(user.id))
      |> Models.Reservation.new()
      |> Result.and_then(&IOs.Reservation.create/1)
    end)
    |> Multi.run(:reserve_letter, fn _, %{get_letter: letter} ->
      letter
      |> update_status(:reserved)
      |> Result.and_then(&Models.Letter.new/1)
    end)
    |> Repo.transaction()
    |> map_multi_error()
    |> Result.map(fn %{reserve_letter: letter} -> letter end)
  end

  @spec update_status(Models.Letter.t(), :reserved) :: Result.t(Models.Letter.t())
  def update_status(old_letter, status) do
    old_letter
    |> Models.Letter.update_status(status)
    |> Result.and_then(&update_letter_in_db(old_letter, &1))
  end

  defp update_letter_in_db(old_letter, new_letter) do
    old_letter
    |> insert_old_letter_values()
    |> Ecto.Changeset.change(Map.from_struct(new_letter))
    |> Repo.update()
  end

  @spec insert_old_letter_values(Models.Letter.t()) :: %Schemas.Letter{}
  defp insert_old_letter_values(%Models.Letter{id: old_letter_id} = old_letter) do
    params =
      old_letter
      |> Map.from_struct()
      |> Map.put(:id, old_letter_id)

    struct(Schemas.Letter, params)
  end

  @spec map_multi_error(Result.t(map())) :: Result.t(map(), atom())
  def map_multi_error({:error, _name, value, _list}), do: Result.error(value)
  def map_multi_error({:ok, _changes} = result), do: result
end
