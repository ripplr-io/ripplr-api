class AddCountsToCommunities < ActiveRecord::Migration[6.1]
  def change
    add_column :communities, :posts_count, :integer, null: false, default: 0
    add_column :communities, :followers_count, :integer, null: false, default: 0
    add_column :users, :following_communities_count, :integer, null: false, default: 0
  end
end
