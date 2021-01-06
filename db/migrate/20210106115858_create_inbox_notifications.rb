class CreateInboxNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :inbox_notifications, id: :uuid do |t|
      t.belongs_to :inbox_item, type: :uuid
      t.belongs_to :inbox_channel, type: :uuid

      t.datetime :scheduled_to
      t.datetime :delivered_at

      t.timestamps
    end

    # There can only exists one notification for each item on each channel
    add_index :inbox_notifications, [:inbox_item_id, :inbox_channel_id], unique: true
  end
end
