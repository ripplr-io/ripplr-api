class AddFollowingTopicsAndFollowingHashtagsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :following_topics_count, :integer, null: false, default: 0
    add_column :users, :following_hashtags_count, :integer, null: false, default: 0
  end
end
