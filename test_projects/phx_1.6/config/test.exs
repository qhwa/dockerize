import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :phx_proj, PhxProj.Repo,
  username: "postgres",
  password: "postgres",
  database: "phx_proj_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phx_proj, PhxProjWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "QYuuAcIz8HoufIg4Pl0578HYZTu8fy2iffDuI6ug/RuASR5EvBAs2+sepmPfhB03",
  server: false

# In test we don't send emails.
config :phx_proj, PhxProj.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
