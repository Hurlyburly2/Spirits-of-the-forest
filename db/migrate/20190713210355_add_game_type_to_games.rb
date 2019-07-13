class AddGameTypeToGames < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.string :game_type, default: "long"
    end
  end
end
