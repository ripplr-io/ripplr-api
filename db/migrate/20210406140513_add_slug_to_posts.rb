class AddSlugToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :slug, :string

    Post.find_each(&:save)

    change_column :posts, :slug, :string, null: false
    add_index :posts, :slug, unique: true
  end
end
