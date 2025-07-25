# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :ridex, Ridex.Guardian,
       issuer: "ridex",
       # You can generate a secret using `mix guardian.gen.secret`
       # as explained here: https://github.com/ueberauth/guardian#installation
       secret_key: "qZpB19ixi+L2MxjDMCJB0fuWUsq0LezLF7z63yR7nC0rJZZ+RI2FQDS7fDvMsGoO"

config :ridex,
  ecto_repos: [Ridex.Repo]

# Configures the endpoint
config :ridex, RidexWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: RidexWeb.ErrorHTML, json: RidexWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Ridex.PubSub,
  live_view: [signing_salt: "2Rg66Jg2"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :ridex, Ridex.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
