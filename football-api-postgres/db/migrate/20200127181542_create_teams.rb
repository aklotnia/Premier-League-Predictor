class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.integer :team_id
      t.string :name
      t.string :code
      t.string :logo
      t.string :country
      t.string :founded
      t.string :stadium_name
      t.string :venue_surface
      t.string :venue_address
      t.string :venue_city
      t.integer :venue_capacity
      t.timestamps
    end
  end
end

# t.string :date
#       t.string :home_team
#       t.string :away_team
#       t.integer :score_home
#       t.integer :score_away