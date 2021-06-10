defmodule SeniorSanta.Repo.Migrations.CreateReservations do
  use Ecto.Migration

  def change do
    create table("reservations", primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:user_id, references(:users, type: :uuid))
      add(:letter_id, references(:letters, type: :uuid))

      timestamps()
    end
  end
end
