class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :body, null: false
      t.string :image, null: false
      t.belongs_to :topic
      t.belongs_to :author, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
