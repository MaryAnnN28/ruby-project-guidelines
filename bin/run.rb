require_relative '../config/environment'
require "tty-prompt"
prompt = TTY::Prompt.new
Player.destroy_all
music_on = false

puts "\n"
music_on = prompt.select("Start w/ music?") do |menu|
  menu.choice "Yes, please!", true
  menu.choice "No, spare me.", false
end
puts "\n"
if music_on == true
  pid = spawn( 'afplay', "music/NBA_on_TNT_Theme.mp3" )
end

#TO DO
# We need to set up associations (belongto hasmany through etc) to access association methods
# We need to finalize data fetching, player stats need to be calculated from all games played. OMG
# We need to finish the backend data tables for players.
# Line below establishes user profile for home screen. Will populate from prompt.
current_user_profile = nil
fav_team = nil
# This part of the program welcomes the user and requests a username. This will load up the favorite team and send to the home screen.
puts "\n"
puts "Welcome to Stats in the Paint!"
puts "\n"

# puts "Please enter your username, or create a new username."
# username = gets.strip
username = prompt.ask("Please enter your username, or create a new username:")
if User.find_by(name: username)
  puts "\n"
  puts "Welcome back!"
  puts "\n"
  current_user_profile = User.find_by(name: username)
  fav_team = Team.find_by(id: Favorite_team_joiner.find_by(user_id: current_user_profile.id).team_id)
  #go straight to home screen with username's favorite team
else
  current_user_profile = User.create(name: username)
  puts "\n"
  favorite_team = prompt.select("New User! Please select a Favorite Team. You will be able to view stats for this team:") do |menu|
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
    menu.choice "Los Angeles Clippers"
    menu.choice "Los Angeles Lakers"
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
  puts "\n"
  Favorite_team_joiner.create(user_id: current_user_profile.id, team_id: Team.find_by(name: favorite_team).id)
  fav_team = Team.find_by(name: favorite_team)
end
# Go to home screen with new username's favorite team.

# This part of the program houses the main menu. From here we have 7 options. This is where we access API and pull favorite team info from conditional.

# Method below adds players to database.
# Need to include method to add stats as well.
fetch_players(fav_team.api_teamID).each{|player|Player.create(name:player[0]+" "+player[1], api_playerID:player[2])}

exit = false
until exit == true
  puts "\n"
  puts "HOME SCREEN"
  puts "\n"
  puts "Hey there #{current_user_profile.name}, Your current favorite team is the #{fav_team.name}."
  puts "\n"
  home_selection = prompt.select("Please select an option from the menu below:") do |menu|
    menu.choice "1. Browse Team Stats", 1
    menu.choice "2. Browse Player Stats", 2
#    menu.choice "3. Browse Interesting Data", 3
    menu.choice "4. Change Favorite Team", 4
#    menu.choice "5. See Team Schedule", 5
#    menu.choice "6. Browse NBA Stats", 6
    menu.choice "7. EXIT", 7
    menu.choice "8. MUSIC ON/OFF", 8
  end
  puts "\n"

# Need to abstract the methods for each option. Potentially add classes?
  if home_selection == 1
    puts "Here are the team stats."
    puts "\n"
    puts fetch_team_stats(fav_team.api_teamID)
    puts "\n"
# Add team stats
  end

  if home_selection == 2
    exit2 = 0
    choices = Player.all.map do |player|
      {name: player.name, value: player}
    end
    until exit2 == 1 do
      player = prompt.select("Please select a player from your favorite team:", choices)
      if player.name == "LeBron James"
        1.times{pid_Lebron = spawn( 'afplay', "music/lebron_james.mp3" )}
      end
      puts "\n"
      puts "You selected #{player.name}! Here are his 2019 season stats:"
      puts "\n"

      # Code below outputs the stats for the seelected player
      if fetch_player_stats(player.api_playerID).class == String
        puts fetch_player_stats(player.api_playerID)
      else
        fetch_player_stats(player.api_playerID).each do |stat_name, stat|
          puts "#{stat_name}:".ljust(20) + "#{stat}".rjust(10)
        end
      end

      puts "\n"
      exit2 = prompt.select("What's next?") do |menu|
        menu.choice "Go Back To Home Screen", 1
        menu.choice "Select Another Player", 0
      end
      puts "\n"
    end
  end

  if home_selection == 3
    # Browse Interesting Data
  end

  if home_selection == 4
    exit4 = 0
    choices = Team.all.map do |team|
      {name: team.name, value: team}
    end
    until exit4 == 1 do
      team = prompt.select("Please select a new favorite team:", choices)
      puts "\n"
      Favorite_team_joiner.find_by(user_id: current_user_profile.id).update(team_id: team.id)
      fav_team = team
      Player.destroy_all
      fetch_players(fav_team.api_teamID).each{|player|Player.create(name:player[0]+" "+player[1], api_playerID:player[2])}
      puts "You selected #{team.name}! They are a great team!"
      puts "\n"
      exit4 = prompt.select("What's next?") do |menu|
        menu.choice "Go Back To Home Screen", 1
        menu.choice "Select A Different Team", 0
      end
      puts "\n"
    end
  end

  if home_selection == 5
    # See Team Schedule
  end

  if home_selection == 6
    # Browse NBA Stats
  end

  if home_selection == 7
    exit = true
    puts "\n"
    puts "Goodbye! Have a great day! Adios!"
    puts "\n"
    pid = fork{ system 'killall', 'afplay' }
  end

  if home_selection == 8
    if music_on == true
      Process.kill "TERM", pid
      music_on = false
    elsif music_on == false
      pid = spawn( 'afplay', "music/NBA_on_TNT_Theme.mp3" )
      music_on = true
    end
  end

end
