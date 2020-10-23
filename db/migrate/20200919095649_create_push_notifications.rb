class CreatePushNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :push_notifications, id: :uuid do |t|
      t.belongs_to :device, type: :uuid
      t.belongs_to :subscription, type: :uuid
      t.belongs_to :post, type: :uuid

      t.string :title, null: false
      t.text :body, null: false
      t.string :thumbnail, null: false

      t.datetime :scheduled_to
      t.datetime :delivered_at

      t.timestamps
    end
  end
end
