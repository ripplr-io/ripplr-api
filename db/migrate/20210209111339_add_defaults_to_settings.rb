class AddDefaultsToSettings < ActiveRecord::Migration[6.1]
  def change
    change_column :channels, :settings, :json, null: false, default: {}
    change_column :inboxes, :settings, :json, null: false, default: {}
  end
end
