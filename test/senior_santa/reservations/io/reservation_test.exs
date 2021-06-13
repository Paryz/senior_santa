defmodule SeniorSanta.Reservations.IO.ReservationTest do
  use SeniorSanta.DataCase

  alias SeniorSanta.Reservations.IO.Reservation
  alias SeniorSanta.Reservations.Models

  describe "create/1" do
    test "params are not a Reservation Model" do
      assert {:error, %Error.DomainError{reason: :bad_request}} = Reservation.create(%{})
    end

    test "params are valid" do
      %{id: user_id} = insert(:user, name: "Johnny Bravo", gender: :male)
      %{id: letter_id} = insert(:letter)
      valid_params = %{"user_id" => user_id, "letter_id" => letter_id}
      {:ok, reservation} = Models.Reservation.new(valid_params)

      assert {:ok, %Models.Reservation{user_id: ^user_id, letter_id: ^letter_id}} =
               Reservation.create(reservation)
    end
  end
end
