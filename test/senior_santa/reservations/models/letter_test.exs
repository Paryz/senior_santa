defmodule SeniorSanta.Reservations.Models.LetterTest do
  use SeniorSanta.DataCase

  alias SeniorSanta.Reservations.Models.Letter

  describe "new/1" do
    test "builds new model struct from ecto struct" do
      letter = insert(:letter, author: "Kamil", content: "contento")

      assert {:ok, %Letter{author: "Kamil", content: "contento"}} = Letter.new(letter)
    end

    test "builds model struct from valid params" do
      letter = params_for(:letter, author: "Kamil", content: "contento")

      assert {:ok, %Letter{author: "Kamil", content: "contento"}} = Letter.new(letter)
    end

    test "returns errors when wrong params" do
      letter = params_for(:letter, author: 1, content: "contento")

      assert {:error,
              %Error.DomainError{
                reason: :failed_to_parse_field,
                caused_by:
                  {:just,
                   %Error.DomainError{caused_by: :nothing, details: %{}, reason: :not_a_string}},
                details: %{field: :author, input: _}
              }} = Letter.new(letter)

      letter = params_for(:letter, author: "Kamil", content: 1)

      assert {:error,
              %Error.DomainError{
                reason: :failed_to_parse_field,
                caused_by:
                  {:just,
                   %Error.DomainError{caused_by: :nothing, details: %{}, reason: :not_a_string}},
                details: %{field: :content, input: _}
              }} = Letter.new(letter)

      letter = params_for(:letter, author: "Kamil", content: "contento", location: 1)

      assert {:error,
              %Error.DomainError{
                reason: :failed_to_parse_field,
                caused_by:
                  {:just,
                   %Error.DomainError{caused_by: :nothing, details: %{}, reason: :not_a_string}},
                details: %{field: :location, input: _}
              }} = Letter.new(letter)

      letter =
        params_for(:letter,
          author: "Kamil",
          content: "contento",
          location: "Warszawa",
          status: "string"
        )

      assert {:error,
              %Error.DomainError{
                reason: :failed_to_parse_field,
                caused_by:
                  {:just,
                   %Error.DomainError{caused_by: :nothing, details: %{}, reason: :not_an_atom}},
                details: %{field: :status, input: _}
              }} = Letter.new(letter)
    end
  end
end
