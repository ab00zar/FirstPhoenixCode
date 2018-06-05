defmodule PandaUi.MatchController do
  use PandaUi.Web, :controller
  
  alias PandaUi.Match

  def index(conn, _params) do
    matches = Match.upcoming_matches
    render conn, "index.html", matches: matches
  end
  
  def show(conn, %{"id" => match_id}) do
    match = Match.odds_using_cache(match_id)
    render conn, "show.html", match: match
  end
end