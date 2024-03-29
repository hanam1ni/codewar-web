# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :codewar,
  ecto_repos: [Codewar.Repo]

config :codewar, Codewar.Repo, migration_primary_key: [type: :uuid]

# Configures the endpoint
config :codewar, CodewarWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1FrpB4JrY0678MpjPf8Pp4Whcv5E6H4RIHdHrU4bM0OxQKGpRR48dQyXx3+qU3gA",
  render_errors: [view: CodewarWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Codewar.PubSub,
  live_view: [signing_salt: "nEr/iREv"]

config :codewar, CodewarWeb.Api, prime_numbers: "97=>804,797=>2001,1999=>68,67=>74,73=>830,829=>-1"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
