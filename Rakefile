require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

# namespace :greeting do
#   desc 'outputs hello to the terminal'
#   task :hello do
#     puts "Welcome to Stats in the Paint!"
#   end
#   desc 'prompts the user for username'
#   task :ask_for_name do
#     puts "Please enter your username, or create a new username."
#   end
#   desc 'welcomes existing user'
#   task :existing do
#     puts "Welcome back!"
#   end
#   desc 'prompts new user for team name'
#   task :new do
#     puts "New User! Please select a Favorite Team. You can only view the stats for this team."
#   end
#   desc 'HOME SCREEN'
#   task :home do
#     puts "HOME SCREEN"
#     puts "Please select an option from the menu below"
#   end
# end
