class AddCountersToModels < ActiveRecord::Migration[6.0]
  def change
    add_column :bookmark_folders, :bookmarks_count, :integer, null: false, default: 0
    add_column :bookmark_folders, :bookmark_folders_count, :integer, null: false, default: 0
    add_column :topics, :posts_count, :integer, null: false, default: 0
    add_column :users, :posts_count, :integer, null: false, default: 0
    add_column :hashtags, :posts_count, :integer, null: false, default: 0
    add_column :topics, :followers_count, :integer, null: false, default: 0
    add_column :users, :followers_count, :integer, null: false, default: 0
    add_column :hashtags, :followers_count, :integer, null: false, default: 0
    add_column :users, :following_count, :integer, null: false, default: 0
  end
end
