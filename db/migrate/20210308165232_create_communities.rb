class CreateCommunities < ActiveRecord::Migration[6.1]
  def change
    create_table :communities, id: :uuid do |t|
      t.belongs_to :owner, type: :uuid, foreign_key: { to_table: :users }

      t.string :name, null: false, limit: 20
      t.string :slug, null: false, limit: 255
      t.text :description, null: false, limit: 500

      t.timestamps
    end

    add_index :communities, :slug, unique: true
  end
end
