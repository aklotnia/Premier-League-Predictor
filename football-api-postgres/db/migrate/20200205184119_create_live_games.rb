class CreateLiveGames < ActiveRecord::Migration[6.0]
  def change
    create_table :live_games do |t|
      t.string :flag
      t.integer :elapsed
      t.integer :home_goals
      t.integer :away_goals
      t.string :home_team
      t.string :away_team
      t.string :home_crest
      t.string :away_crest

      t.timestamps
    end
  end
end
