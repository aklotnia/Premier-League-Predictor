class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :date
      t.string :home_team
      t.string :away_team
      t.integer :score_home
      t.integer :score_away
      t.string :result
      t.string :stadium
      t.timestamps
    end
  end
end
