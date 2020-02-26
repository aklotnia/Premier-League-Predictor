class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :position
      t.string :name
      t.string :image
      t.integer :games_played

      t.float :goals_per_game
      t.float :assists_per_game
      t.float :big_chances_created_per_game
      t.integer :shooting_accuracy

      t.float :conceded_per_game
      t.float :tackles_per_game
      t.integer :tackle_accuracy
      t.float :errors_leading_to_goals_per_game

      t.integer :interceptions_per_game
      t.integer :aerial_win_rate
      t.integer :through_balls_per_game
      t.float :passes_per_game

      t.integer :save_percentage
      t.integer :penalty_kick_save_percentage
      t.integer :accurate_long_balls_per_game


      t.integer :team_id
      t.timestamps
    end
  end
end
