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



def fetch_player_stats(api_playerId)
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
     player_game_avg = season_2019.each {|game| {"points" => game["points"], "min" => game["min"], "totReb" => game["totReb"], "assists" => game["assists"], "steals" => game["steals"], "block" => game["blocks"], "plusMinus" => game["plusMinus"]}}
     # DON't forget to add fgm, fga, tpm, tpa 

     total_points = player_game_avg.sum { |game| game["points"].to_i }.to_s
     # ppg = total_points/total_games
     # fgp = total_fgm/total_fga 
     # ftp = total_ftm/total_fta 
     # ttp = total_ttm/total_fta 
     # rpg = 
     # apg 
     # spg 
     # bpg
     # plusMinus_avg = total_plusMinus/total games
     # returns hash of players season averages 
end


# def fetch_team_stats(api_teamId)
#      # Returns hash of teams season stats ("win", "loss", "winPercentage", "home record" => "31/"4" , "away record" => "12"/"26")
# end 



