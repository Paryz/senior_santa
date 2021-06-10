defmodule SeniorSanta.ValidatorsTest do
  use SeniorSanta.DataCase

  alias SeniorSanta.Validators

  describe "email_valid?/1" do
    test "email is not a binary" do
      assert false == Validators.email_valid?(1)
      assert false == Validators.email_valid?(1.0)
      assert false == Validators.email_valid?(%{})
      assert false == Validators.email_valid?(:test)
    end

    test "email is not matching the regexp" do
      assert false == Validators.email_valid?("test")
      assert false == Validators.email_valid?("test@")
      assert false == Validators.email_valid?("@test")
      assert false == Validators.email_valid?("test@test")
      assert false == Validators.email_valid?("test@test.")
    end

    test "email is valid" do
      assert true == Validators.email_valid?("test@email.com")
    end
  end

  describe "polish_phone_number_valid?/1" do
    test "phone is not a binary" do
      assert false == Validators.polish_phone_number_valid?(1)
      assert false == Validators.polish_phone_number_valid?(1.0)
      assert false == Validators.polish_phone_number_valid?(%{})
      assert false == Validators.polish_phone_number_valid?(:test)
    end

    test "phone is not matching the regexp" do
      assert false == Validators.polish_phone_number_valid?("1")
      assert false == Validators.polish_phone_number_valid?("11")
      assert false == Validators.polish_phone_number_valid?("111")
      assert false == Validators.polish_phone_number_valid?("1111")
      assert false == Validators.polish_phone_number_valid?("11111")
      assert false == Validators.polish_phone_number_valid?("111111")
      assert false == Validators.polish_phone_number_valid?("1111111")
      assert false == Validators.polish_phone_number_valid?("11333444")
    end

    test "phone is valid" do
      assert true == Validators.polish_phone_number_valid?("111333444")
      assert true == Validators.polish_phone_number_valid?("111-333-444")
      assert true == Validators.polish_phone_number_valid?("+48111333444")
      assert true == Validators.polish_phone_number_valid?("+48555444333")
      assert true == Validators.polish_phone_number_valid?("+48 111333444")
      assert true == Validators.polish_phone_number_valid?("+48 111-333-444")
      assert true == Validators.polish_phone_number_valid?("+48 111 333 444")
      assert true == Validators.polish_phone_number_valid?("0048111333444")
      assert true == Validators.polish_phone_number_valid?("0048 111333444")
    end
  end
end
