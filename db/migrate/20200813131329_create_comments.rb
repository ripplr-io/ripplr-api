class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.text :body, null: false
      t.belongs_to :post, type: :uuid
      t.belongs_to :comment, type: :uuid
      t.belongs_to :author, type: :uuid, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
