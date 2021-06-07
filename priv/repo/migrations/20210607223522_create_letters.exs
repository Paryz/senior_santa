defmodule SeniorSanta.Repo.Migrations.CreateLetters do
  use Ecto.Migration

  def change do
    create table("letters") do
      add(:location, :string)
      add(:content, :string)
      add(:author, :string)
      add(:status, :string)

      timestamps()
    end
  end
end
