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
     player_game_avg = season_2019.each {|game| {"points" => game["points"], "min" => game["min"], "fgm" => game["fgm"], "fga" => game["fga"], "tpm" => game["tpm"], "tpa" => game["tpa"], "totReb" => game["totReb"], "assists" => game["assists"], "steals" => game["steals"], "block" => game["blocks"], "plusMinus" => game["plusMinus"]}}


     total_points = player_game_avg.sum { |game| game["points"].to_i }.to_s
     ppg = total_points.to_i / player_game_avg.count # becomes rounded to whole numbers...need float?

     fgm = player_game_avg.sum { |game| game["fgm"].to_i } # need for fgp
     fga = player_game_avg.sum { |game| game["fga"].to_i } # need for fgp
     fgp = ((fgm.to_f/fga.to_f).round(3))*100

     ftm = player_game_avg.sum { |game| game["ftm"].to_i } # need for ftp
     fta = player_game_avg.sum { |game| game["fta"].to_i } # need for ftp
     ftp = ((ftm.to_f/fta.to_f)*100).round(3)

     tpm = player_game_avg.sum { |game| game["tpm"].to_i } # need for tpp
     tpa = player_game_avg.sum { |game| game["tpa"].to_i } # need for tpp
     tpp = ((tpm.to_f/tpa.to_f)*100).round(3)

     rpg = player_game_avg.sum { |game| game["totReb"].to_i } / player_game_avg.count
     apg = player_game_avg.sum { |game| game["assists"].to_i } / player_game_avg.count
     spg = player_game_avg.sum { |game| game["steals"].to_i } / player_game_avg.count
     ##NEED REVIEW#  bpg = player_game_avg.sum { |game| game["blocks"].to_f } / player_game_avg.count
    ##NEED REVIEW plusMinus_avg = player_game_avg.sum { |game| game["plusMinus"].to_i } / player_game_avg.count

    # returns hash of players season averages
    player_season_avg = ["points" => ppg, "fgp" => fgp, "ftp" => ftp, "tpp" => tpp, "rpg" => rpg, "apg" => apg, "spg" => spg]
end


def fetch_team_stats(api_teamId)

     url = URI("https://api-nba-v1.p.rapidapi.com/standings/standard/2019/teamId/27")

     http = Net::HTTP.new(url.host, url.port)
     http.use_ssl = true
     http.verify_mode = OpenSSL::SSL::VERIFY_NONE

     request = Net::HTTP::Get.new(url)
     request["x_rapidapi_key"] = ENV['x_rapidapi_key']
     request["x-rapidapi-host"] = 'api-nba-v1.p.rapidapi.com'

     response = http.request(request)
# Returns hash of teams season stats ("win", "loss", "winPercentage", "home record" => "31/"4" , "away record" => "12"/"26")
end
