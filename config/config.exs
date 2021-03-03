# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :webdevhw07,
  ecto_repos: [Webdevhw07.Repo]

# Configures the endpoint
config :webdevhw07, Webdevhw07Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kXXXKvqKMH2/kmWrDoPp1lBnPw/iof6WuTz8jXTlUDhr6L13kNku2EfSFmVQ7Hxi",
  render_errors: [view: Webdevhw07Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Webdevhw07.PubSub,
  live_view: [signing_salt: "GpjeZBlA"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
