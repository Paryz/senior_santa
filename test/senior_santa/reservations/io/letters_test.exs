defmodule SeniorSanta.Reservations.IO.LettersTest do
  use SeniorSanta.DataCase

  alias SeniorSanta.Reservations.IO.Letters
  alias SeniorSanta.Reservations.Models

  describe "get_all_by_location/1" do
    test "no letters found" do
      assert FE.Result.ok([]) == Letters.get_all_by_location(location: "Kielce")
    end

    test "letters found" do
      insert(:letter, location: "Kielce", content: "kielce")

      assert {:ok, [%Models.Letter{content: "kielce"}]} =
               Letters.get_all_by_location(location: "Kielce")
    end
  end
end
