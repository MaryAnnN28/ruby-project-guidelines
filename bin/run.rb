require_relative '../config/environment'
require "tty-prompt"
prompt = TTY::Prompt.new
Player.destroy_all

# App starts without music and below option allows to turn on.
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
  choices = Team.all.map do |team|
    {name: team.name, value: team}
  end
  fav_team = prompt.select("New User! Please select a Favorite Team. You will be able to view stats for this team:", choices)
  puts "\n"
  Favorite_team_joiner.create(user_id: current_user_profile.id, team_id: fav_team.id)
end
# Now travel to home screen with new username's favorite team.

### This part of the program houses the main menu. From here we have 7 options. This is where we access API and pull favorite team info from conditional.

# Method below adds players to database.
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
    menu.choice "3. Change Favorite Team", 3
    menu.choice "4. EXIT", 4
    menu.choice "5. MUSIC ON/OFF", 5
  end
  puts "\n"

# Need to abstract the methods for each option. Potentially add classes?
  if home_selection == 1
    puts "Here are the team stats for the #{fav_team.name}."
    puts "\n"
    fetch_team_stats(fav_team.api_teamID).each do |stat_name, stat|
      puts "#{stat_name}:".ljust(20) + "#{stat}".rjust(10)
    end
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
    exit3 = 0
    choices = Team.all.map do |team|
      {name: team.name, value: team}
    end
    until exit3 == 1 do
      team = prompt.select("Please select a new favorite team:", choices)
      puts "\n"
      Favorite_team_joiner.find_by(user_id: current_user_profile.id).update(team_id: team.id)
      fav_team = team
      Player.destroy_all
      fetch_players(fav_team.api_teamID).each{|player|Player.create(name:player[0]+" "+player[1], api_playerID:player[2])}
      puts "You selected #{team.name}! They are a great team!"
      puts "\n"
      exit3 = prompt.select("What's next?") do |menu|
        menu.choice "Go Back To Home Screen", 1
        menu.choice "Select A Different Team", 0
      end
      puts "\n"
    end
  end

  if home_selection == 4
    exit = true
    puts "\n"
    puts "Goodbye! Have a great day! Adios!"
    puts "\n"
    pid = fork{ system 'killall', 'afplay' }
  end

  if home_selection == 5
    if music_on == true
      Process.kill "TERM", pid
      music_on = false
    elsif music_on == false
      pid = spawn( 'afplay', "music/NBA_on_TNT_Theme.mp3" )
      music_on = true
    end
  end

end
