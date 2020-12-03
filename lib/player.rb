class Player < ActiveRecord::Base
  belongs_to :teams

  def add_stats(games)
  season_2019 = games.select { |game| game["gameId"].to_i > 6230 && game["min"].to_i > 0 }
     player_game_avg = season_2019.each {|game| {"points" => game["points"], "min" => game["min"], "fgm" => game["fgm"], "fga" => game["fga"], "tpm" => game["tpm"], "tpa" => game["tpa"], "totReb" => game["totReb"], "assists" => game["assists"], "steals" => game["steals"], "block" => game["blocks"], "plusMinus" => game["plusMinus"]}}


     total_points = player_game_avg.sum { |game| game["points"].to_i }.to_s
     ppg = total_points.to_f / player_game_avg.count.round(2) # becomes rounded to whole numbers...need float?


     fgm = player_game_avg.sum { |game| game["fgm"].to_i } # need for fgp
     fga = player_game_avg.sum { |game| game["fga"].to_i } # need for fgp
     fgp = ((fgm.to_f/fga.to_f).round(2))*100
   

     ftm = player_game_avg.sum { |game| game["ftm"].to_i } # need for ftp
     fta = player_game_avg.sum { |game| game["fta"].to_i } # need for ftp
     ftp = ((ftm.to_f/fta.to_f)*100).round(2)

     tpm = player_game_avg.sum { |game| game["tpm"].to_i } # need for tpp
     tpa = player_game_avg.sum { |game| game["tpa"].to_i } # need for tpp
     tpp = ((tpm.to_f/tpa.to_f)*100).round(2)

     rpg = player_game_avg.sum { |game| game["totReb"].to_i } / player_game_avg.count
     apg = player_game_avg.sum { |game| game["assists"].to_i } / player_game_avg.count
     spg = player_game_avg.sum { |game| game["steals"].to_i } / player_game_avg.count
     bpg = player_game_avg.sum { |game| game["blocks"].to_f } / player_game_avg.count
    ##NEED REVIEW plusMinus_avg = player_game_avg.sum { |game| game["plusMinus"].to_i } / player_game_avg.count

    # returns hash of players season averages
     player_season_avg = {"points" => ppg, "fgp" => fgp, "ftp" => ftp, "tpp" => tpp, "rpg" => rpg, "apg" => apg, "spg" => spg}
  end

end

