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

  def uuid_valid?(uuid) do
    is_binary(uuid) and
      uuid =~ ~r/^[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[089ab][0-9a-f]{3}-[0-9a-f]{12}$/
  end
end
