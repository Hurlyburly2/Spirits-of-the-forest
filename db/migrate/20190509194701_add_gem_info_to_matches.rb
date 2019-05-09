class AddGemInfoToMatches < ActiveRecord::Migration[5.2]
  def change
    change_table :matches do |t|
      t.integer :gems_possessed, default: 3
      t.integer :gems_total, default: 3
    end
  end
end
