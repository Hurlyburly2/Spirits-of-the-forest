class CreateAppstamp < ActiveRecord::Migration[5.2]
  def change
    create_table :appstamps do |t|
      t.timestamp :last_activity_check
    end
  end
end
