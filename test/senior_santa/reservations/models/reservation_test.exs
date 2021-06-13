defmodule SeniorSanta.Reservations.Models.ReservationTest do
  use SeniorSanta.DataCase

  alias SeniorSanta.Reservations.Models.Reservation

  describe "new/1" do
    test "builds new model struct from ecto struct" do
      %{id: user_id} = insert(:user, name: "Johnny Bravo", gender: :male)
      %{id: letter_id} = insert(:letter)

      %{id: reservation_id} =
        reservation = insert(:reservation, user_id: user_id, letter_id: letter_id)

      assert {:ok,
              %Reservation{id: {:just, ^reservation_id}, user_id: ^user_id, letter_id: ^letter_id}} =
               Reservation.new(reservation)
    end

    @user_id Ecto.UUID.generate()
    @letter_id Ecto.UUID.generate()

    @valid_params %{
      "user_id" => @user_id,
      "letter_id" => @letter_id
    }

    test "builds model struct from valid params" do
      %{
        "user_id" => user_id,
        "letter_id" => letter_id
      } = @valid_params

      assert {:ok, %Reservation{id: :nothing, user_id: ^user_id, letter_id: ^letter_id}} =
               Reservation.new(@valid_params)
    end

    test "returns errors when wrong params" do
      params = %{@valid_params | "user_id" => 1}

      assert {:error,
              %Error.DomainError{
                reason: :failed_to_parse_field,
                caused_by:
                  {:just,
                   %Error.DomainError{
                     caused_by: :nothing,
                     details: %{},
                     reason: :predicate_not_satisfied
                   }},
                details: %{field: :user_id, input: _}
              }} = Reservation.new(params)

      params = %{@valid_params | "user_id" => "not_uuid"}

      assert {:error,
              %Error.DomainError{
                reason: :failed_to_parse_field,
                caused_by:
                  {:just,
                   %Error.DomainError{
                     caused_by: :nothing,
                     details: %{},
                     reason: :predicate_not_satisfied
                   }},
                details: %{field: :user_id, input: _}
              }} = Reservation.new(params)

      params = %{@valid_params | "letter_id" => 1}

      assert {:error,
              %Error.DomainError{
                reason: :failed_to_parse_field,
                caused_by:
                  {:just,
                   %Error.DomainError{
                     caused_by: :nothing,
                     details: %{},
                     reason: :predicate_not_satisfied
                   }},
                details: %{field: :letter_id, input: _}
              }} = Reservation.new(params)

      params = %{@valid_params | "letter_id" => "not_uuid"}

      assert {:error,
              %Error.DomainError{
                reason: :failed_to_parse_field,
                caused_by:
                  {:just,
                   %Error.DomainError{
                     caused_by: :nothing,
                     details: %{},
                     reason: :predicate_not_satisfied
                   }},
                details: %{field: :letter_id, input: _}
              }} = Reservation.new(params)
    end
  end
end
