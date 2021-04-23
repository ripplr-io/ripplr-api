class RemoveAttributesFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :name
    remove_column :users, :slug
    remove_column :users, :bio
  end
end
