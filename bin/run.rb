require_relative '../config/environment'

#TO DO
# We need to set up associations (belongto hasmany through etc) to access association methods
# We need to finalize data fetching
# We need to

# This part of the program welcomes the user and requests a username. This will load up the favorite team and send to the home screen.
puts "Welcome to Stats in the Paint!"
# puts "Please enter your username, or create a new username."
# username = gets.strip
username = prompt.ask("Please enter your username, or create a new username. (No spaces or special characters Mr.Hackerman)")

if User.find_by(name: username)
  puts "Welcome back!"
else
  new = User.create(name: username)
  # puts "New User! Please select a Favorite Team. You can only view the stats for this team."
  # favorite_team = gets.strip
  favorite_team = prompt.select("New User! Please select a Favorite Team. You can only view the stats for this team.") do |menu|
    menu.choice "Atlanta Hawks", atlanta
    menu.choice "Boston Celtics", boston
    menu.choice "Brooklyn Nets", brooklyn
    menu.choice "Charlotte Hornets", charlotte
    menu.choice "Chicago Bulls", chicago
    menu.choice "Cleveland Cavaliers", cleveland
    menu.choice "Dallas Mavericks", dallas
    menu.choice "Denver Nuggets", denver
    menu.choice "Detroit Pistons", detroit
    menu.choice "Golden State Warriors", golden
    menu.choice "Houston Rockets", houston
    menu.choice "Indiana Pacers", indiana
    menu.choice "Las Angeles Clippers", clippers
    menu.choice "Las Angeles Lakers", lakers
    menu.choice "Memphis Grizzlies", memphis
    menu.choice "Miami Heat", miami
    menu.choice "Milwaukee Bucks", milwaukee
    menu.choice "Minnesota Timberwolves", minnesota
    menu.choice "New Orleans Pelicans", new_orleans
    menu.choice "New York Knicks", new_york
    menu.choice "Oklahoma Thunder", oklahoma
    menu.choice "Orlando Magic", orlando
    menu.choice "Philadelphia 76ers", philadelphia
    menu.choice "Phoenix Suns", phoenix
    menu.choice "Portland Blazers", portland
    menu.choice "Sacremento Kings", sacremento
    menu.choice "San Antonio Spurs", san_antonio
    menu.choice "Toronto Raptors", toronto
    menu.choice "Utah Jazz", utah
    menu.choice "Washington Wizards", washington
  end

  Favorite_team_joiner.create(user_id: new.id, team_id: favorite_team.id)
end

puts "HOME SCREEN"
puts "Please select an option from the menu below"

# This part of the program houses the main menu. From here we have 7 options. This is where we access API and pull favorite team info from conditional.


api_teamID





# Here is the engine for the 7 options






# Here is the exit program routine
