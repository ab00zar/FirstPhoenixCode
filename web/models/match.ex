defmodule PandaUi.Match do
    
    use PandaUi.Web, :model

    def upcoming_matches do
        url = "https://api.pandascore.co/matches/upcoming?sort=begin_at&page[size]=5&token=" <> "_43x3U-PSvgZN-g8_ixuferP1C_dFg-xloXzxhprwglQ8ka4p8M"
        %{body: body} = HTTPoison.get!(url, [], [ ssl: [{:versions, [:'tlsv1.2']}] ])
        r = Poison.Parser.parse! body
        for n <- r, do: %{"begin_at" => n["begin_at"], "id" => n["id"], "name" => n["name"]}
    end

    def odds_for_match(match_id) do
        url = "https://api.pandascore.co/matches/" <> Integer.to_string(match_id) <> "?&token=" <> "_43x3U-PSvgZN-g8_ixuferP1C_dFg-xloXzxhprwglQ8ka4p8M"
        %{body: body} = HTTPoison.get!(url, [], [ ssl: [{:versions, [:'tlsv1.2']}] ])
        r = Poison.Parser.parse! body

        #Number of matches opponent1 won
        opp1_won_matches_url = "https://api.pandascore.co/matches/?filter[winner_id]=" <> Integer.to_string(List.first(r["opponents"])["id"]) 
          <> "&token=" <> "_43x3U-PSvgZN-g8_ixuferP1C_dFg-xloXzxhprwglQ8ka4p8M"
        %{body: body} = HTTPoison.get!(opp1_won_matches_url, [], [ ssl: [{:versions, [:'tlsv1.2']}] ])
        opp1_won_matches = length(Poison.Parser.parse! body)

        #Number of matches opponent2 won
        opp2_won_matches_url = "https://api.pandascore.co/matches/?filter[winner_id]=" <> Integer.to_string(List.last(r["opponents"])["id"]) 
          <> "&token=" <> "_43x3U-PSvgZN-g8_ixuferP1C_dFg-xloXzxhprwglQ8ka4p8M"
        %{body: body} = HTTPoison.get!(opp2_won_matches_url, [], [ ssl: [{:versions, [:'tlsv1.2']}] ])
        opp2_won_matches = length(Poison.Parser.parse! body)

        #Calculate odds based on the number of matches each opponent won before
        ratio = if (opp1_won_matches == 0 || opp2_won_matches == 0), do: :rand.uniform, else: opp1_won_matches / opp2_won_matches
        opp2_odds = 100 / (ratio + 1)
        opp1_odds = 100 - opp2_odds

        %{List.first(r["opponents"])["opponent"]["name"] => opp1_odds, List.last(r["opponents"])["opponent"]["name"] => opp2_odds}
    end
    
    def odds_using_cache(match_id) do
        if PandaUi.Cache.has_key?(match_id) do
            #IO.puts "It's available in the cache"
            PandaUi.Cache.get(match_id)
        else
            result = odds_for_match(match_id)
            #IO.inspect result
            #"The result is stored in the cache for future requests"
            PandaUi.Cache.set(match_id, result)
        end
    end 
    
end