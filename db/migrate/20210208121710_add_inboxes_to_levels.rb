class AddInboxesToLevels < ActiveRecord::Migration[6.1]
  def change
    add_column :levels, :inboxes, :integer

    Level.update_all('inboxes=subscriptions')

    change_column :levels, :inboxes, :integer, null: false
  end
end
