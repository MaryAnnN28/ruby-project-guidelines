class Player < ActiveRecord::Base
  belongs_to :teams


  def self.add_stats(games)
  
     player_game_avg = games.each {|game| {"points" => game["points"], "min" => game["min"], "fgm" => game["fgm"], "fga" => game["fga"], "tpm" => game["tpm"], "tpa" => game["tpa"], "totReb" => game["totReb"], "assists" => game["assists"], "steals" => game["steals"], "block" => game["blocks"], "plusMinus" => game["plusMinus"]}}


     total_points = player_game_avg.sum { |game| game["points"].to_i }.to_s
     ppg = (total_points.to_f / player_game_avg.count).round(2) # becomes rounded to whole numbers...need float?

     mpg = (player_game_avg.sum { |game| game["min"].to_i }.to_f / player_game_avg.count).round(2)

     fgm = player_game_avg.sum { |game| game["fgm"].to_i } # need for fgp
     fga = player_game_avg.sum { |game| game["fga"].to_i } # need for fgp
     fgp = ((fgm.to_f/fga.to_f)*100).round(2)
   

     ftm = player_game_avg.sum { |game| game["ftm"].to_i } # need for ftp
     fta = player_game_avg.sum { |game| game["fta"].to_i } # need for ftp
     ftp = ((ftm.to_f/fta.to_f)*100).round(2)

     tpm = player_game_avg.sum { |game| game["tpm"].to_i } # need for tpp
     tpa = player_game_avg.sum { |game| game["tpa"].to_i } # need for tpp
     tpp = ((tpm.to_f/tpa.to_f)*100).round(2)

     rpg = (player_game_avg.sum { |game| game["totReb"].to_i }.to_f / player_game_avg.count).round(2)
     apg = (player_game_avg.sum { |game| game["assists"].to_i }.to_f / player_game_avg.count).round(2)
     spg = (player_game_avg.sum { |game| game["steals"].to_i }.to_f / player_game_avg.count).round(2)
     bpg = (player_game_avg.sum { |game| game["blocks"].to_i }.to_f / player_game_avg.count).round(2)
     plusMinus_avg = (player_game_avg.sum { |game| game["plusMinus"].to_i }.to_f / player_game_avg.count).round(2)

    # returns hash of players season averages
     player_season_avg = {"Points Per Game" => ppg, "Min Per Game" => mpg, "Field Goal %" => fgp, "Free Throw %" => ftp, "3-Point %" => tpp, "Rebounds Per Game" => rpg, "Assists Per Game" => apg, "Steals Per Game" => spg, "Blocks Per Game" => bpg, "Plus/Minus Avg" => plusMinus_avg }
  end

end

