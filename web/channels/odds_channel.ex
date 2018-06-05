defmodule PandaUi.OddsChannel do
    use PandaUi.Web, :channel
    
    alias PandaUi.Match
    
    def join("odds:" <> match_id, _params, socket) do
        match_id = String.to_integer(match_id)
        odds = Match.odds_using_cache(match_id)
        IO.puts("+++++++++")
        IO.puts(match_id)
        IO.puts("++++++++")
        IO.inspect(odds)
        {:ok, %{odds: odds}, socket}
    end
    
    def handle_in(name, message, socket) do
        {:reply, :ok, socket}
    end
end