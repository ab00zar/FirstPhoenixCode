defmodule PandaUi.Match do
    
    use PandaUi.Web, :model

    def upcoming_matches do
        url = "https://api.pandascore.co/matches/upcoming?sort=begin_at&page[size]=5&token=" <> "_43x3U-PSvgZN-g8_ixuferP1C_dFg-xloXzxhprwglQ8ka4p8M"
        %{body: body} = HTTPoison.get!(url, [], [ ssl: [{:versions, [:'tlsv1.2']}] ])
        r = Poison.Parser.parse! body
        for n <- r, do: %{"begin_at" => n["begin_at"], "id" => n["id"], "name" => n["name"]}
        #"yesss"
    end
    
end