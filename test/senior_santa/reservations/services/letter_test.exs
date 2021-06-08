defmodule SeniorSanta.Reservations.Services.LetterTest do
  use SeniorSanta.DataCase

  alias SeniorSanta.Reservations.Models
  alias SeniorSanta.Reservations.Services.Letter

  describe "get/1" do
    test "no letter found" do
      id = Ecto.UUID.generate()

      assert FE.Result.error(:not_found) == Letter.get(id)
    end

    test "letter found" do
      %{id: letter_id} = insert(:letter, location: "Kielce", content: "kielce")

      assert {:ok, %Models.Letter{id: ^letter_id}} = Letter.get(letter_id)
    end
  end
end
