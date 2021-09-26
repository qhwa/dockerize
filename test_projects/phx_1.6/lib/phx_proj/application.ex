defmodule PhxProj.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PhxProj.Repo,
      # Start the Telemetry supervisor
      PhxProjWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhxProj.PubSub},
      # Start the Endpoint (http/https)
      PhxProjWeb.Endpoint
      # Start a worker by calling: PhxProj.Worker.start_link(arg)
      # {PhxProj.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxProj.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxProjWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
