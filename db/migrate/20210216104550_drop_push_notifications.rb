class DropPushNotifications < ActiveRecord::Migration[6.1]
  def up
    drop_table :push_notifications
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
