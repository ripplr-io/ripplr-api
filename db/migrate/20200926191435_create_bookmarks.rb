class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmark_folders do |t|
      t.belongs_to :user
      t.belongs_to :bookmark_folder
      t.string :name, null: false

      t.timestamps
    end

    create_table :bookmarks do |t|
      t.belongs_to :bookmark_folder
      t.belongs_to :post

      t.timestamps
    end
  end
end
