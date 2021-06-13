defmodule SeniorSanta.Reservations.Services.UserTest do
  use SeniorSanta.DataCase

  alias SeniorSanta.Reservations.IO.Schemas
  alias SeniorSanta.Reservations.Services.User
  alias SeniorSanta.Reservations.Models

  describe "create/1" do
    @valid_params %{
      "gender" => "male",
      "phone" => "+48555444333",
      "email" => "email@email.com",
      "city" => "Warszawa",
      "name" => "Forest Gump",
      "date_of_birth" => "1998-01-03"
    }
    test "params are wrong" do
      params = %{}
      assert {:error, %Error.DomainError{reason: :field_not_found_in_input}} = User.create(params)

      params = %{@valid_params | "gender" => 1}
      assert {:error, %Error.DomainError{reason: :failed_to_parse_field}} = User.create(params)

      params = %{@valid_params | "gender" => "test"}
      assert {:error, %Error.DomainError{reason: :failed_to_parse_field}} = User.create(params)

      params = %{@valid_params | "phone" => 1}
      assert {:error, %Error.DomainError{reason: :failed_to_parse_field}} = User.create(params)

      params = %{@valid_params | "phone" => "123"}
      assert {:error, %Error.DomainError{reason: :failed_to_parse_field}} = User.create(params)

      params = %{@valid_params | "name" => 1}
      assert {:error, %Error.DomainError{reason: :failed_to_parse_field}} = User.create(params)

      params = %{@valid_params | "email" => 1}
      assert {:error, %Error.DomainError{reason: :failed_to_parse_field}} = User.create(params)

      params = %{@valid_params | "email" => "adasdf@"}
      assert {:error, %Error.DomainError{reason: :failed_to_parse_field}} = User.create(params)

      params = %{@valid_params | "date_of_birth" => "adasdf@"}
      assert {:error, %Error.DomainError{reason: :failed_to_parse_field}} = User.create(params)
    end

    test "params are valid" do
      assert {:ok, %Models.User{id: {:just, user_id}}} = User.create(@valid_params)
      assert %Schemas.User{} = SeniorSanta.Repo.get(Schemas.User, user_id)
    end
  end
end
