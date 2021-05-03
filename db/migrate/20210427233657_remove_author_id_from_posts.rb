class RemoveAuthorIdFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :following_users_count
    remove_column :users, :followers_count
    remove_column :users, :posts_count
    remove_reference :posts, :author
  end
end
