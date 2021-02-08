class AddDescriptionToInboxes < ActiveRecord::Migration[6.1]
  def change
    add_column :inboxes, :description, :text
    add_column :inbox_items, :archived_at, :datetime
  end
end
