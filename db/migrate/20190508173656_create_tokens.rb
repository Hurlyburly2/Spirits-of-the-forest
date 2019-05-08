class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :spirit, null: false
      t.string :image_url, null: false
    end
  end
end
