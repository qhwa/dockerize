defmodule SimpleApp do
  @moduledoc """
  Just a basic web server app.
  """

  use Application

  def start(_type, _arg) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: __MODULE__.Server, options: [port: 4001]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  defmodule Server do
    import Plug.Conn

    def init(_), do: []

    def call(conn, _) do
      conn
      |> put_resp_content_type("text/plain")
      |> send_resp(200, "Hello, world")
    end
  end
end
