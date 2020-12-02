require_relative '../config/environment'
require "tty-prompt"
prompt = TTY::Prompt.new

#TO DO
# We need to set up associations (belongto hasmany through etc) to access association methods
# We need to finalize data fetching, player stats need to be calculated from all games played. OMG
# We need to finish the backend data tables for players.

# This part of the program welcomes the user and requests a username. This will load up the favorite team and send to the home screen.
puts "Welcome to Stats in the Paint!"
# puts "Please enter your username, or create a new username."
# username = gets.strip
username = prompt.ask("Please enter your username, or create a new username. (No spaces or special characters Mr.Hackerman)")

if User.find_by(name: username)
  puts "Welcome back!"
  #go straight to home screen with username's favorite team
else
  new = User.create(name: username)
  favorite_team = prompt.select("New User! Please select a Favorite Team. You can only view the stats for this team.") do |menu|
    menu.choice "Atlanta Hawks"
    menu.choice "Boston Celtics"
    menu.choice "Brooklyn Nets"
    menu.choice "Charlotte Hornets"
    menu.choice "Chicago Bulls"
    menu.choice "Cleveland Cavaliers"
    menu.choice "Dallas Mavericks"
    menu.choice "Denver Nuggets"
    menu.choice "Detroit Pistons"
    menu.choice "Golden State Warriors"
    menu.choice "Houston Rockets"
    menu.choice "Indiana Pacers"
    menu.choice "Las Angeles Clippers"
    menu.choice "Las Angeles Lakers"
    menu.choice "Memphis Grizzlies"
    menu.choice "Miami Heat"
    menu.choice "Milwaukee Bucks"
    menu.choice "Minnesota Timberwolves"
    menu.choice "New Orleans Pelicans"
    menu.choice "New York Knicks"
    menu.choice "Oklahoma Thunder"
    menu.choice "Orlando Magic"
    menu.choice "Philadelphia 76ers"
    menu.choice "Phoenix Suns"
    menu.choice "Portland Blazers"
    menu.choice "Sacremento Kings"
    menu.choice "San Antonio Spurs"
    menu.choice "Toronto Raptors"
    menu.choice "Utah Jazz"
    menu.choice "Washington Wizards"
  end
  favorite_team_data = Team.find_by(name: favorite_team)
  Favorite_team_joiner.create(user_id: new.id, team_id: favorite_team_data.id)
  #go to home screen with new username's favorite team
end


# This part of the program houses the main menu. From here we have 7 options. This is where we access API and pull favorite team info from conditional.
puts "\n"
puts "HOME SCREEN"
puts "Please select an option from the menu below"

# 1) Browse Team Stats
# 2) Browse Player Stats
# 3) Browse Interesting Data
# 4) Change Favorite Team
# 5) See Team Schedule
# 6) Browse NBA Stats
# 7) EXIT



# api_teamID





# Here is the engine for the 7 options






# Here is the exit program routine
