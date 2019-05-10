class AddProfileImageToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.integer :which_profile_pic
    end
  end
end
