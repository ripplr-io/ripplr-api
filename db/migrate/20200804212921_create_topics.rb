class CreateTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :topics do |t|
      t.string :name, null: false
      t.text :description
      t.string :avatar, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_index :topics, :slug, unique: true
  end
end
