class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :spirit, null: false
      t.integer :spirit_points, null: false
      t.integer :spirit_count, null: false
      t.string :element, null: false
      t.string :image_url, null: false
    end
  end
end
