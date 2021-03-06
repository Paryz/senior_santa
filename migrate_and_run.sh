#!/bin/bash

export PGPASSWORD="${POSTGRES_PASSWORD}"
export PGUSER="${POSTGRES_USER}"
export PGDATABASE="${POSTGRES_DB}"
export PGPORT="${POSTGRES_PORT}"

# Wait until Postgres is ready
while ! pg_isready -q -h "db"
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.
if [[ -z `psql -Atqc "\\list $POSTGRES_DB"` ]]; then
  echo "Database $POSTGRES_DB does not exist. Creating..."
  createdb -E UTF8 $POSTGRES_DB -l en_US.UTF-8 -T template0
  echo "Database $POSTGRES_DB created."
fi

./prod/rel/senior_santa/bin/senior_santa eval SeniorSanta.ReleaseTasks.migrate

./prod/rel/senior_santa/bin/senior_santa start
