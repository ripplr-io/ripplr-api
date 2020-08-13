class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.belongs_to :post
      t.belongs_to :author, foreign_key: { to_table: :users }
      t.belongs_to :parent, foreign_key: { to_table: :comments }

      t.timestamps
    end
  end
end
