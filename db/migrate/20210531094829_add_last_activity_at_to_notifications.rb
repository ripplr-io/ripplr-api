class AddLastActivityAtToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :last_activity_at, :datetime

    reversible do |dir|
      dir.up { Notification.update_all('last_activity_at = created_at') }
    end

    change_column :notifications, :last_activity_at, :datetime, null: false
  end
end
