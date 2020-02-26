class CreateStandings < ActiveRecord::Migration[6.0]
  def change
    create_table :standings do |t|
      t.string :position
      t.string :name
      t.string :crest
      t.integer :played_games
      t.integer :won_games
      t.integer :drawn_games
      t.integer :lost_games
      t.integer :points
      t.integer :goals_for
      t.integer :goals_against
      t.integer :goal_difference
    end
  end
end
