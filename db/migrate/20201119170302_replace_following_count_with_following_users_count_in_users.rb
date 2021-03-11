class ReplaceFollowingCountWithFollowingUsersCountInUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :following_count, :integer, null: false, default: 0
    add_column :users, :following_users_count, :integer, null: false, default: 0
  end
end
