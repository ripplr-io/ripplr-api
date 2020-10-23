class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :body, null: false
      t.string :image, null: false
      t.belongs_to :topic, type: :uuid
      t.belongs_to :author, type: :uuid, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
