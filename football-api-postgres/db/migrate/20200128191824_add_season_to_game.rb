class AddSeasonToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :season, :string
  end
end
