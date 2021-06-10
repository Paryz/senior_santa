defmodule SeniorSanta.Reservations.Models.UserTest do
  use SeniorSanta.DataCase

  alias SeniorSanta.Reservations.Models.User

  describe "new/1" do
    test "builds new model struct from ecto struct" do
      user = insert(:user, name: "Johnny Bravo", gender: :male)

      assert {:ok, %User{name: "Johnny Bravo", gender: :male}} = User.new(user)
    end

    test "builds model struct from valid params" do
      user = params_for(:user, name: "Johnny Bravo")

      assert {:ok, %User{name: "Johnny Bravo"}} = User.new(user)
    end

    test "returns errors when wrong params" do
      user = params_for(:user, name: 1)

      assert {:error,
              %Error.DomainError{
                reason: :failed_to_parse_field,
                caused_by:
                  {:just,
                   %Error.DomainError{caused_by: :nothing, details: %{}, reason: :not_a_string}},
                details: %{field: :name, input: _}
              }} = User.new(user)

      user = params_for(:user, name: "John Doe", email: 1)

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
                details: %{field: :email, input: _}
              }} = User.new(user)

      user = params_for(:user, name: "John Doe", email: "aaa")

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
                details: %{field: :email, input: _}
              }} = User.new(user)

      user = params_for(:user, name: "John Doe", email: "aaa@")

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
                details: %{field: :email, input: _}
              }} = User.new(user)

      user = params_for(:user, name: "John Doe", city: 1)

      assert {:error,
              %Error.DomainError{
                reason: :failed_to_parse_field,
                caused_by:
                  {:just,
                   %Error.DomainError{caused_by: :nothing, details: %{}, reason: :not_a_string}},
                details: %{field: :city, input: _}
              }} = User.new(user)

      user =
        params_for(:user,
          name: "John Doe",
          city: "Warszawa",
          gender: "string"
        )

      assert {:error,
              %Error.DomainError{
                reason: :failed_to_parse_field,
                caused_by:
                  {:just,
                   %Error.DomainError{
                     caused_by: :nothing,
                     details: %{},
                     reason: :gender_is_not_valid
                   }},
                details: %{field: :gender, input: _}
              }} = User.new(user)

      user =
        params_for(:user,
          name: "John Doe",
          city: "Warszawa",
          gender: :string
        )

      assert {:error,
              %Error.DomainError{
                reason: :failed_to_parse_field,
                caused_by:
                  {:just,
                   %Error.DomainError{
                     caused_by: :nothing,
                     details: %{},
                     reason: :gender_is_not_valid
                   }},
                details: %{field: :gender, input: _}
              }} = User.new(user)
    end
  end
end
