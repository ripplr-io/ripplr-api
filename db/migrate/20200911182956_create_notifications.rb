class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.string :notification_type, null: false
      t.json :data, null: false
      t.datetime :read_at

      t.timestamps
    end
  end
end
