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
     request["x-rapidapi-key"] = 'deaf59203fmshce09f7b6c729ccap1bfcfdjsnd303908d1191'
     request["x-rapidapi-host"] = 'api-nba-v1.p.rapidapi.com'

     response = http.request(request)
     
     favorite_team_active_players = JSON.parse(response.read_body)["api"]["players"].select {|player| player["leagues"].has_key?("standard")}.select {|player| player["leagues"]["standard"]["active"]=="1"}
     favorite_team_active_players.map {|player| [player["firstName"], player["lastName"], player["playerId"]]}

end 



def fetch_player_game(api_playerId)
     url = URI("https://api-nba-v1.p.rapidapi.com/statistics/players/playerId/#{api_playerId}")

     http = Net::HTTP.new(url.host, url.port)
     http.use_ssl = true
     http.verify_mode = OpenSSL::SSL::VERIFY_NONE

     request = Net::HTTP::Get.new(url)
     request["x-rapidapi-key"] = 'deaf59203fmshce09f7b6c729ccap1bfcfdjsnd303908d1191'
     request["x-rapidapi-host"] = 'api-nba-v1.p.rapidapi.com'

     response = http.request(request)

     favorite_team_player_games = JSON.parse(response.read_body)["api"]["statistics"]
     season_2019 = favorite_team_player_games.select { |game| game["gameId"].to_i > 6230 && game["min"].to_i > 0 } 
     player_game_avg = season_2019.each {|game| {"points" => game["points"], "min" => game["min"], "fgp" => game["fgp"], "ftp" => game["ftp"], "tpp" => game["tpp"], "totReb" => game["totReb"], "assists" => game["assists"], "steals" => game["steals"], "block" => game["blocks"], "plusMinus" => game["plusMinus"]}}

     total_points = player_game_avg.select { |points| points.sum }
     # total_min = player_game_avg
     # total_fgp = 
     # total_ftp = 
     # total_ttp
     # total_totReb
     # total_assists
     # total_steals
     # total_blocks
     # total_plusMinus
end




# [{"gameId"=>"6300", "teamId"=>"31", "points"=>"13", "pos"=>"", "min"=>"21:07", "fgm"=>"5", "fga"=>"8", "fgp"=>"62.5", "ftm"=>"2", "fta"=>"2", "ftp"=>"100", "tpm"=>"1", "tpa"=>"2", "tpp"=>"50.0", "offReb"=>"0", "defReb"=>"3", "totReb"=>"3", "assists"=>"2", "pFouls"=>"3", "steals"=>"0", "turnovers"=>"4", "blocks"=>"0", "plusMinus"=>"8", "playerId"=>"1899"},


# RapidAPI
# For Team game:   GET/Standings/    "https://api-nba-v1.p.rapidapi.com/standings/standard/2019"
# For Player game:      GET/statistics/players/playerId   "https://api-nba-v1.p.rapidapi.com/statistics/players/playerId/1896"