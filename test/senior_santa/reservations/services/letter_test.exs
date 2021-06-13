defmodule SeniorSanta.Reservations.Services.LetterTest do
  use SeniorSanta.DataCase

  alias SeniorSanta.Reservations.IO.Schemas
  alias SeniorSanta.Reservations.Models
  alias SeniorSanta.Reservations.Services.Letter

  describe "get/1" do
    test "no letter found" do
      id = Ecto.UUID.generate()

      assert {:error, %Error.DomainError{reason: :letter_not_found}} = Letter.get(id)
    end

    test "letter found" do
      %{id: letter_id} = insert(:letter, location: "Kielce", author: "John")

      assert {:ok, %Models.Letter{id: ^letter_id}} = Letter.get(letter_id)
    end
  end

  describe "reserve/1" do
    test "letter is not found" do
      params = %{
        "city" => "Warszawa",
        "date_of_birth" => "1989-32-3",
        "email" => "john@doe.com",
        "gender" => "female",
        "letter_id" => Ecto.UUID.generate(),
        "name" => "John Doe",
        "phone" => "+48555444333"
      }

      assert {:error, %Error.DomainError{reason: :letter_not_found}} = Letter.reserve(params)
    end

    test "wrong user params" do
      letter = insert(:letter)

      params = %{
        "city" => 1,
        "date_of_birth" => "1989-32-3",
        "email" => "john@doe.com",
        "gender" => "female",
        "letter_id" => letter.id,
        "name" => "John Doe",
        "phone" => "+48555444333"
      }

      assert nil == Repo.get_by(Schemas.User, email: "john@doe.com")

      assert {:error, %Error.DomainError{reason: :failed_to_parse_field}} = Letter.reserve(params)
    end

    test "user and reservation are being created and letter status is updated" do
      letter = insert(:letter)

      params = %{
        "city" => "Warszawa",
        "date_of_birth" => "1989-02-03",
        "email" => "john@doe.com",
        "gender" => "female",
        "letter_id" => letter.id,
        "name" => "John Doe",
        "phone" => "+48555444333"
      }

      assert {:ok, %Models.Letter{status: :zarezerwowany}} = Letter.reserve(params)
      assert %Schemas.User{id: user_id} = Repo.get_by(Schemas.User, email: "john@doe.com")
      assert %Schemas.Reservation{} = Repo.get_by(Schemas.Reservation, user_id: user_id)
    end
  end
end
