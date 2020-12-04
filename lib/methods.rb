require 'uri'
require 'net/http'
require 'openssl'
require 'byebug'
require 'json'

def fetch_players(api_teamId)
     url = URI("https://api-nba-v1.p.rapidapi.com/players/teamId/#{api_teamId}")

     http = Net::HTTP.new(url.host, url.port)
     http.use_ssl = true
     http.verify_mode = OpenSSL::SSL::VERIFY_NONE

     request = Net::HTTP::Get.new(url)
     request["x-rapidapi-key"] = $api_key
     request["x-rapidapi-host"] = 'api-nba-v1.p.rapidapi.com'

     response = http.request(request)

     favorite_team_active_players = JSON.parse(response.read_body)["api"]["players"].select {|player| player["leagues"].has_key?("standard")}.select {|player| player["leagues"]["standard"]["active"]=="1"}
     favorite_team_active_players.map {|player| [player["firstName"], player["lastName"], player["playerId"]]}
    
      

end



def fetch_player_stats(api_playerID)
     url = URI("https://api-nba-v1.p.rapidapi.com/statistics/players/playerId/#{api_playerID}")

     http = Net::HTTP.new(url.host, url.port)
     http.use_ssl = true
     http.verify_mode = OpenSSL::SSL::VERIFY_NONE

     request = Net::HTTP::Get.new(url)
     request["x-rapidapi-key"] = $api_key
     request["x-rapidapi-host"] = 'api-nba-v1.p.rapidapi.com'

     response = http.request(request)

     favorite_team_player_games = JSON.parse(response.read_body)["api"]["statistics"]
     season_2019 = favorite_team_player_games.select { |game| game["gameId"].to_i > 6230 && game["min"].to_i > 0 }

     if season_2019.count == 0 
          "Sorry, but #{Player.find_by(api_playerID: api_playerID).name} did not play in 2019 season."
     else
          Player.add_stats(season_2019) 
     end


end






def fetch_team_stats(api_teamId)

     url = URI("https://api-nba-v1.p.rapidapi.com/standings/standard/2019/teamId/#{api_teamId}")

     http = Net::HTTP.new(url.host, url.port)
     http.use_ssl = true
     http.verify_mode = OpenSSL::SSL::VERIFY_NONE

     request = Net::HTTP::Get.new(url)
     request["x-rapidapi-key"] = 'deaf59203fmshce09f7b6c729ccap1bfcfdjsnd303908d1191'
     request["x-rapidapi-host"] = 'api-nba-v1.p.rapidapi.com'

     response = http.request(request)

     stats = JSON.parse(response.read_body)["api"]["standings"][0]

     team_season_stats = {"Wins" => stats["win"], "Loses" => stats["loss"], "Win %" => stats["winPercentage"], "Home Record" => "#{stats["home"]["win"]}-#{stats["home"]["loss"]}", "Away Record" => "#{stats["away"]["win"]}-#{stats["away"]["loss"]}"}
end


# Returns hash of teams season stats ("win", "loss", "winPercentage", "home record" => "31/"4" , "away record" => "12"/"26")
