class AddWinnerColumnToGame < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.integer :winner_id, default: nil
    end
  end
end
