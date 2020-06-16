# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :truckin,
  ecto_repos: [Truckin.Repo]

# Configures the endpoint
config :truckin, TruckinWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Uar1FGBegBMbuVumQRICFly8G6RsE8sBcIrfONn/3WH3oKmepgsMxBWCjwd5Lgsf",
  render_errors: [view: TruckinWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Truckin.PubSub,
  live_view: [signing_salt: "Mc534Jad"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
