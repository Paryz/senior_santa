use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :senior_santa, SeniorSanta.Repo,
  username: "postgres",
  password: "postgres",
  database: "senior_santa_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :senior_santa, SeniorSantaWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :senior_santa, SeniorSanta.Mailer,
  adapter: Bamboo.TestAdapter

# Dont run oban in tests
config :senior_santa, Oban, queues: false, plugins: false