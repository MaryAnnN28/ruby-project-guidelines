class CreateFavTeamJoiner < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_team_joiners do |t|
    t.string :name
    t.integer :user_id
    t.integer :team_id
    end
  end
end
