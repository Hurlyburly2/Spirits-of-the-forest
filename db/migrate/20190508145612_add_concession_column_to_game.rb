class AddConcessionColumnToGame < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.boolean :concession, default: false
    end
  end
end
