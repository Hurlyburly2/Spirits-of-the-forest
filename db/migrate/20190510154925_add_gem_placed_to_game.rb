class AddGemPlacedToGame < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.boolean :gem_placed, default: false
    end
  end
end
