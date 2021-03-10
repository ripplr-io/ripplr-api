class CreateCommunityPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :community_posts, id: :uuid do |t|
      t.belongs_to :community, type: :uuid
      t.belongs_to :post, type: :uuid

      t.timestamps
    end
  end
end
