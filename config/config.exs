# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mudala,
  ecto_repos: [Mudala.Repo]

# Configures the endpoint
config :mudala, MudalaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "A7yTudWJUOUbYMUpbIBHje9T3y75Lgs1LqfdCio6PAXT3O91nqrDgm9vzNiwb2tx",
  render_errors: [view: MudalaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mudala.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :mudala, MudalaWeb.Gettext,
  default_locale: "fr"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
