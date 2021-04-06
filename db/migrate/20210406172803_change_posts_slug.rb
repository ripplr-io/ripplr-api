class ChangePostsSlug < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :slug, :string, null: false
    add_index :posts, :slug, unique: true
  end
end
