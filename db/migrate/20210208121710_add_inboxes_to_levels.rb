class AddInboxesToLevels < ActiveRecord::Migration[6.1]
  def change
    add_column :levels, :inboxes, :integer, null: false
  end
end
