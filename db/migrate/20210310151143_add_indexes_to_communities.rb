class AddIndexesToCommunities < ActiveRecord::Migration[6.1]
  def change
    # A community cannot have the same topic twice
    add_index :community_topics, [:community_id, :topic_id], unique: true

    # A post cannot have the same community twice
    add_index :community_posts, [:community_id, :post_id], unique: true
  end
end
