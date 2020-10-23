class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.string :notification_type, null: false
      t.json :data, null: false
      t.datetime :read_at

      t.timestamps
    end
  end
end
