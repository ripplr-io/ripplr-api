class AddAttributesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :bio, :text
    add_column :users, :avatar, :string
    add_column :users, :slug, :string, null: false

    add_index :users, :slug, unique: true
  end
end
