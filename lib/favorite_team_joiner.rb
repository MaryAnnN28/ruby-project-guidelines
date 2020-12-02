class Favorite_team_joiner < ActiveRecord::Base
  belongs_to :teams
  belongs_to :users
end
