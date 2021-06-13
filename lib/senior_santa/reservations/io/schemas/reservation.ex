defmodule SeniorSanta.Reservations.IO.Schemas.Reservation do
  use Ecto.Schema

  alias SeniorSanta.Reservations.IO.Schemas

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "reservations" do
    belongs_to(:user, Schemas.User)
    belongs_to(:letter, Schemas.Letter)

    timestamps()
  end
end
