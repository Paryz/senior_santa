defmodule SeniorSanta.Reservations.IO.Schemas.Letter do
  use Ecto.Schema

  alias SeniorSanta.Reservations.IO.Schemas

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "letters" do
    field(:location, :string)
    field(:content, :string)
    field(:author, :string)
    field(:status, Ecto.Enum, values: [:active, :reserved])

    has_one(:reservation, Schemas.Reservation)

    timestamps()
  end
end
