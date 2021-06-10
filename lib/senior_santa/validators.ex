defmodule SeniorSanta.Validators do
  def email_valid?(email) do
    is_binary(email) and email =~ ~r/^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
  end

  def polish_phone_number_valid?(phone) do
    is_binary(phone) and
      phone =~ ~r/(?<!\w)(\(?(\+|00)?48\)?)?[ -]?\d{3}[ -]?\d{3}[ -]?\d{3}(?!\w)/
  end

  @valid_genders [:male, :female, :other]
  def gender_valid?(gender) when gender in @valid_genders, do: true

  def gender_valid?(gender) when is_binary(gender) do
    String.to_existing_atom(gender) in @valid_genders
  end
end
