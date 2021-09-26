defmodule PhxProjWeb.PageController do
  use PhxProjWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
