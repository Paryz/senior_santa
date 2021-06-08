defmodule SeniorSanta.Reservations.IO.LettersTest do
  use SeniorSanta.DataCase

  alias SeniorSanta.Reservations.IO.Letters
  alias SeniorSanta.Reservations.Models

  describe "get_all_by_location/1" do
    test "no letters found" do
      assert FE.Result.ok([]) == Letters.get_all_by_location("Kielce")
    end

    test "letters found" do
      insert(:letter, location: "Kielce", author: "John")
      insert(:letter, location: "Warszawa", author: "Benny")

      assert {:ok, [%Models.Letter{author: "John"}]} = Letters.get_all_by_location("Kielce")
    end
  end

  describe "get/1" do
    test "no letter found" do
      id = Ecto.UUID.generate()

      assert FE.Maybe.nothing() == Letters.get(id)
    end

    test "letter found" do
      %{id: letter_id} = insert(:letter, location: "Kielce", author: "John")

      assert {:just, %Models.Letter{id: ^letter_id}} = Letters.get(letter_id)
    end
  end
end
