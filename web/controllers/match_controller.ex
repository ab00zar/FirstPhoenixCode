defmodule PandaUi.MatchController do
  use PandaUi.Web, :controller
  
  alias PandaUi.Match

  def index(conn, _params) do
    matches = Match.upcoming_matches
    render conn, "index.html", matches: matches
  end
  
  def show(conn, %{"id" => match_id}) do
    render conn, "show.html", match_id: match_id
  end
end