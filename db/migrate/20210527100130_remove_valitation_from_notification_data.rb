class RemoveValitationFromNotificationData < ActiveRecord::Migration[6.1]
  def change
    change_column :notifications, :data, :json, null: true
  end
end
