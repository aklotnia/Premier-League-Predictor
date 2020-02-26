class AddDescriptionToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :description, :text
  end
end
