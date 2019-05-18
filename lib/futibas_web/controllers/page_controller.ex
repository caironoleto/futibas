defmodule FutibasWeb.PageController do
  use FutibasWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
