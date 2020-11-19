class ReplaceFollowingCountWithFollowingUsersCountInUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :following_count, :integer, null: false, default: 0
    add_column :users, :following_users_count, :integer, null: false, default: 0

    BookmarkFolder.counter_culture_fix_counts
    Bookmark.counter_culture_fix_counts
    Comment.counter_culture_fix_counts
    Follow.counter_culture_fix_counts
    Post.counter_culture_fix_counts
    PostHashtag.counter_culture_fix_counts
    Rating.counter_culture_fix_counts
  end
end
