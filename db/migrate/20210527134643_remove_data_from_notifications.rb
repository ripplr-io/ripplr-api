class RemoveDataFromNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :data
    remove_column :notifications, :type
  end
end
