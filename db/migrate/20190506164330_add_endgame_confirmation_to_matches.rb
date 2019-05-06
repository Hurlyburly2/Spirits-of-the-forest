class AddEndgameConfirmationToMatches < ActiveRecord::Migration[5.2]
  def change
    change_table :matches do |t|
      t.boolean :endgame_confirm, default: false
    end
  end
end
