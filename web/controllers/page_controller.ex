defmodule PandaUi.PageController do
  use PandaUi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
