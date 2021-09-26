defmodule PhxProj.Repo do
  use Ecto.Repo,
    otp_app: :phx_proj,
    adapter: Ecto.Adapters.Postgres
end
