# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :scorer_api,
  ecto_repos: [ScorerApi.Repo]

# Configures the endpoint
config :scorer_api, ScorerApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YscdMPu8HRKvD+XQh6t0d2S2tSM2mv50m7nUme1nYDie33Xc5yEh4U87DEmVsND5",
  render_errors: [view: ScorerApiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ScorerApi.PubSub,
  live_view: [signing_salt: "oG9DMLyG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
