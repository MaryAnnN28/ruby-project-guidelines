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
     favorite_team_player_games
     
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

     favorite_team_stats = JSON.parse(response.read_body)["api"]["statistics"]

end

# Returns hash of teams season stats ("win", "loss", "winPercentage", "home record" => "31/"4" , "away record" => "12"/"26")
