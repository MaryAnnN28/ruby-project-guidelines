class User < ActiveRecord::Base
  has_many :teams, through: :favorite_team_joiners
end
