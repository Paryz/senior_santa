defmodule SeniorSanta.Repo.Migrations.ChangeDateOfBirthToDate do
  use Ecto.Migration

  def up do
    alter table("users") do
      modify :date_of_birth, :date
    end
  end

  def down do
    alter table("users") do
      modify :date_of_birth, :utc_datetime
    end
  end
end
