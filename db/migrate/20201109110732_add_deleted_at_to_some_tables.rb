class AddDeletedAtToSomeTables < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :deleted_at, :datetime
    add_column :posts, :deleted_at, :datetime
    add_column :post_hashtags, :deleted_at, :datetime
    add_column :ratings, :deleted_at, :datetime

    add_index :comments, :deleted_at
    add_index :posts, :deleted_at
    add_index :post_hashtags, :deleted_at
    add_index :ratings, :deleted_at
  end
end
