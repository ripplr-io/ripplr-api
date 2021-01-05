class AddUniqueIndexToInboxName < ActiveRecord::Migration[6.1]
  def change
    # A user cannot have two Inboxes with the same name
    add_index :inboxes, [:user_id, :name], unique: true
  end
end
