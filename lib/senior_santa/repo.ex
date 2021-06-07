defmodule SeniorSanta.Repo do
  use Ecto.Repo,
    otp_app: :senior_santa,
    adapter: Ecto.Adapters.Postgres
end
