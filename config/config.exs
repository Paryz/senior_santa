# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :senior_santa, ecto_repos: [SeniorSanta.Repo], generators: [binary_id: true]

# Configures the endpoint
config :senior_santa, SeniorSantaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gezCztOVJKD3K7/pRxOCsVz2/26KpvIXP6iwcLAtR6kikK55jKMTPDbjxLrheGDc",
  render_errors: [view: SeniorSantaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SeniorSanta.PubSub,
  live_view: [signing_salt: "ywIHqVZp"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :waffle,
  storage: Waffle.Storage.Local,
  # storage: Waffle.Storage.S3,
  bucket: System.get_env("AWS_BUCKET_NAME")

# If using S3:
config :ex_aws,
  json_codec: Jason,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  region: System.get_env("AWS_REGION")

config :senior_santa, SeniorSanta.Mailer,
  adapter: Bamboo.MandrillAdapter,
  api_key: "my_api_key"

config :kaffy,
  otp_app: :senior_santa,
  ecto_repo: SeniorSanta.Repo,
  router: SeniorSantaWeb.Router

config :senior_santa, Oban,
  repo: SeniorSanta.Repo,
  queues: [default: 10, mailers: 20, events: 50, low: 5],
  plugins: [Oban.Plugins.Pruner]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
