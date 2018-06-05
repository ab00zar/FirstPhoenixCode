defmodule PandaUi.MatchController do
  use PandaUi.Web, :controller
  
  alias PandaUi.Match

  def index(conn, _params) do
    matches = Match.upcoming_matches
    render conn, "index.html", matches: matches
  end
end