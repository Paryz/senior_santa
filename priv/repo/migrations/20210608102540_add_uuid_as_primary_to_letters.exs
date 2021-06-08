defmodule SeniorSanta.Repo.Migrations.AddUuidAsPrimaryToLetters do
  use Ecto.Migration

  def up do
    alter table("letters") do
      add :uuid, :uuid, default: fragment("gen_random_uuid()"), null: false
    end

    rename(table("letters"), :id, to: :integer_id)
    rename(table("letters"), :uuid, to: :id)

    execute "ALTER TABLE letters drop constraint letters_pkey;"
    execute "ALTER TABLE letters ADD PRIMARY KEY (id);"

    # Optionally you remove auto-incremented
    # default value for integer_id column
    execute "ALTER TABLE ONLY letters ALTER COLUMN integer_id DROP DEFAULT;"

    alter table("letters") do
      modify :integer_id, :bigint, null: true
    end

    execute "DROP SEQUENCE IF EXISTS letters_id_seq"
  end

  def down do
    raise Ecto.MigrationError, "Irreversible migration"
  end
end
