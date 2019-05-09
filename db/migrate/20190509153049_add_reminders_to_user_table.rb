class AddRemindersToUserTable < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.boolean :reminders, default: false
    end
  end
end
