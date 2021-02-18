class AddCountersToInbox < ActiveRecord::Migration[6.1]
  def change
    add_column :inboxes, :inbox_items_count, :integer, null: false, default: 0
    add_column :inboxes, :inbox_items_archived_count, :integer, null: false, default: 0
    add_column :inboxes, :subscription_inboxes_count, :integer, null: false, default: 0
  end
end
