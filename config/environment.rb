require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_relative './.api_key.rb'
ActiveRecord::Base.logger = nil


require "tty-prompt"
#require "HTTParty"
require 'json'
require 'open-uri'
require 'colorize'
