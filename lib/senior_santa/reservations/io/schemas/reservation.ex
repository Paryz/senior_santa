defmodule SeniorSanta.Reservations.IO.Schemas.Reservation do
  use Ecto.Schema

  alias SeniorSanta.Reservations.IO.Schemas

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "reservations" do
    belongs_to(:user, Schema.User)
    belongs_to(:letter, Schemas.Letter)

    timestamps()
  end
end
