class AddTokensColumnToMatches < ActiveRecord::Migration[5.2]
  def change
    change_table :matches do |t|
      t.text :tokens
    end
  end
end
