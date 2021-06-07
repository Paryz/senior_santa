defmodule SeniorSanta.Reservations.IO.Schemas.Letter do
  use Ecto.Schema

  schema "letters" do
    field(:location, :string)
    field(:content, :string)
    field(:author, :string)
    field(:status, :string)

    timestamps()
  end
end
