class AddSelectedCardsToMatchesTable < ActiveRecord::Migration[5.2]
  def change
    change_table :matches do |t|
      t.text :selected_cards
    end
  end
end
