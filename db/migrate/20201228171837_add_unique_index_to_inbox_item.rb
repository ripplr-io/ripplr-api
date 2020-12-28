class AddUniqueIndexToInboxItem < ActiveRecord::Migration[6.0]
  def change
    # An inboxable item cannot be in the same inbox multiple times
    add_index :inbox_items, [:inbox_id, :inboxable_id, :inboxable_type], unique: true,
      name: 'ux_inbox_items_inbox_inboxable'
  end
end
