defmodule SeniorSanta.Reservations.IO.UserTest do
  use SeniorSanta.DataCase

  alias SeniorSanta.Reservations.IO.User
  alias SeniorSanta.Reservations.Models

  describe "create/1" do
    test "params are not a User Model" do
      assert {:error, %Error.DomainError{reason: :bad_request}} = User.create(%{})
    end

    test "params are valid" do
      {:ok, user} = params_for(:user, name: "Forest Gump") |> Models.User.new()

      assert {:ok, %Models.User{name: "Forest Gump"}} = User.create(user)
    end
  end
end
