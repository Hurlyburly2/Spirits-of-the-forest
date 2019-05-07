class AddRecordRelatedColumnsToUserTable < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.integer :wins, default: 0
      t.integer :losses, default: 0
      t.string :rank, default: "bronze"
      t.integer :rankup_score, default: 0
    end
  end
end
