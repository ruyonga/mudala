use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mudala, MudalaWeb.Endpoint,
  http: [port: 4001],
  server: true

config :hound, driver: "phantomjs"

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :mudala, Mudala.Repo,
  username: "postgres",
  password: "postgres",
  database: "parents_center_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
