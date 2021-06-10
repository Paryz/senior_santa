defmodule SeniorSanta.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table("users", primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:name, :string)
      add(:email, :string)
      add(:city, :string)
      add(:phone, :string)
      add(:date_of_birth, :utc_datetime)
      add(:gender, :string)

      timestamps()
    end
  end
end
