require_relative '../config/environment'

# Do we need to create a new database table here for users?

# This part of the program welcomes the user and requests a username. This will load up the favorite team and send to the home screen.
# rake greeting:hello
puts "Welcome to Stats in the Paint!"
# rake greeting:ask_for_name
puts "Please enter your username, or create a new username."


username = gets.strip

if User.find_by(name: username)
  # rake greeting:existing
  puts "Welcome back!"
else
  new = User.create(name: username)
  # rake greeting:new
  puts "New User! Please select a Favorite Team. You can only view the stats for this team."
  favorite_team = gets.strip
  Favorite_team_joiner.create(user_id: new.id, team_id: favorite_team.id)
end

# rake greeting:home
puts "HOME SCREEN"
puts "Please select an option from the menu below"

# This part of the program houses the main menu. From here we have 7 options. This is where we access API and pull favorite team info from conditional.








# Here is the engine for the 7 options






# Here is the exit program routine
