class ChangeTable < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.integer :whose_turn_id
    end
  end
end
