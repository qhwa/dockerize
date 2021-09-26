# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phoenix_app,
  ecto_repos: [PhoenixApp.Repo]

# Configures the endpoint
config :phoenix_app, PhoenixAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "N+ZBKIx7Bqq4UkdIs/Q4nphlYnPcU6+maWPRKXdgI8F8LZp2H8ptgRxIbw9opfRL",
  render_errors: [view: PhoenixAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PhoenixApp.PubSub,
  live_view: [signing_salt: "W9MTO+wH"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
