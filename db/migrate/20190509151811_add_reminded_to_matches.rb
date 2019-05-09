class AddRemindedToMatches < ActiveRecord::Migration[5.2]
  def change
    change_table :matches do |t|
      t.boolean :reminded, default: false
    end
  end
end
