defmodule SeniorSanta.Reservations.IO.Schemas.User do
  use Ecto.Schema

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:city, :string)
    field(:phone, :string)
    field(:date_of_birth, :utc_datetime)
    field(:gender, Ecto.Enum, values: [:female, :male, :other])

    timestamps()
  end
end