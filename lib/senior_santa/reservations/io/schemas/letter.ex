defmodule SeniorSanta.Reservations.IO.Schemas.Letter do
  use Ecto.Schema

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "letters" do
    field(:location, :string)
    field(:content, :string)
    field(:author, :string)
    field(:status, Ecto.Enum, values: [:aktywny, :zarezerwowany])

    timestamps()
  end
end
