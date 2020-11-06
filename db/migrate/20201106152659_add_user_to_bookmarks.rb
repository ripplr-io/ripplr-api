class AddUserToBookmarks < ActiveRecord::Migration[6.0]
  def change
    add_reference :bookmarks, :user, type: :uuid

    # A user cannot bookmark a post multiple times
    add_index :bookmarks, [:user_id, :post_id], unique: true
  end
end
