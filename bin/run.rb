require_relative '../config/environment'

# Do we need to create a new database table here for users?

# This part of the program welcomes the user and requests a username. This will load up the favorite team and send to the home screen.
rake greeting:hello
rake greeting:ask_for_name

username = gets.strip

if User.find_by(name: username)
  rake greeting:existing
else
  user = User.new(username)
  User.create(name: username)
  user.name = 'Steve'
  user.save
  rake greeting:new




end

rake greeting:home




# This part of the program houses the main menu. From here we have 7 options








# Here is the engine for the 7 options






# Here is the exit program routine
