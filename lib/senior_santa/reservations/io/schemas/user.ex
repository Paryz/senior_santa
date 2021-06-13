defmodule SeniorSanta.Reservations.IO.Schemas.User do
  use Ecto.Schema

  alias SeniorSanta.Reservations.IO.Schemas

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:city, :string)
    field(:phone, :string)
    field(:date_of_birth, :date)
    field(:gender, Ecto.Enum, values: [:female, :male, :other])

    has_many(:reservations, Schemas.Reservation)
    timestamps()
  end
end
