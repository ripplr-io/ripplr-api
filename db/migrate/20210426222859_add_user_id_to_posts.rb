class AddUserIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :posts_count, :integer, null: false, default: 0
    add_reference :posts, :profile, type: :uuid
  end
end
