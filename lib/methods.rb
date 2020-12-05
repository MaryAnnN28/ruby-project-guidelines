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
     request["x-rapidapi-key"] = $api_key
     request["x-rapidapi-host"] = 'api-nba-v1.p.rapidapi.com'

     response = http.request(request)

     stats = JSON.parse(response.read_body)["api"]["standings"][0]

     team_season_stats = {"Wins" => stats["win"], "Loses" => stats["loss"], "Win %" => stats["winPercentage"], "Home Record" => "#{stats["home"]["win"]}-#{stats["home"]["loss"]}", "Away Record" => "#{stats["away"]["win"]}-#{stats["away"]["loss"]}"}
end




def random_fun_facts
     "The first three-point shot in the NBA was made by Boston Celtics guard Chris Ford on October 12, 1979, against the Houston Rockets."
     "Steals and blocks only became official (recorded) stats in the NBA starting from the 1973-1974 season. During that season, Elmore Smith recored the most blocks in an NBA game with 17 on October 28, 1973."
     "The 24-second shot clock was the brainchild of Syracuse Nationals owner Danny Biasone and general manager Leo Ferris. The NBA first adopted the shot clock during the 1954-1955 season."
     "There have been two women drafted in the NBA. The first was Denise Long who was drafted in the 13th round by the San Francisco Warriors. The second was Luisa Harris, who was drafted by the New Orleans Jazz as the 137th overall draft pick"
end



def team_season_leaders

logo = <<-logo

                                                  SEASON LEADERS

         POINTS PER GAME                       ASSISTS PER GAME                      REBOUNDS PER GAME
      1. Milwaukee Bucks          118.7     1. Phoenix Suns             27.2      1. Milwaukee Bucks          51.7
      2. Houston Rockets          117.8     2. Memphis Grizzlies        26.9      2. Brooklyn Nets            47.9
      3. Dallas Mavericks         117.0     3. New Orleans Pelicans     26.8      3. LA Clippers              47.7
      4. LA Clippers              116.3     4. Denver Nuggets           26.7      4. Dallas Mavericks         46.9
      5. New Orleans Pelicans     115.8     5. Indiana Pacers           25.9      5. Memphis Grizzlies        46.5


         BLOCKS PER GAME                       STEALS PER GAME                      FIELD GOAL PERCENTAGE
      1. Los Angeles Lakers       6.6       1. Chicago Bulls            10.0      1. Los Angeles Lakers       48.0
      2. Portland Trail Blazers   6.1       2. Toronto Raptors          8.8       2. Indiana Pacers           47.6
      3. Milwaukee Bucks          5.9       3. Houston Rockets          8.7       3. Milwaukee Bucks          47.6
      4. Minnesota Timberwolves   5.7       4. Minnesota Timberwolves   8.7       4. Denver Nuggets           47.3
      5. Boston Celtics           5.6       5. Los Angeles Lakers       8.6       5. San Antonio Spurs        47.2


         THREE POINTERS MADE                   THREE POINT PERCENTAGE               FREE THROW PERCENTAGE
      1. Dallas Mavericks         1136      1. Utah Jazz                38.0      1. Phoenix Suns             83.4
      2. Houston Rockets          1126      2. Miami Heat               37.9      2. San Antonio Spurs        81.0
      3. Milwaukee Bucks          1007      3. Portland Trail Blazers   37.7      3. Portland Trail Blazers   80.4
      4. Toronto Raptors          995       4. San Antonio Spurs        37.6      4. Golden State Warriors    80.3
      5. New Orleans Pelicans     982       5. Toronto Raptors          37.4      5. Boston Celtics           80.1

      logo

      puts logo

end
