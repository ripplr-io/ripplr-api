class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmark_folders, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.belongs_to :bookmark_folder, type: :uuid
      t.string :name, null: false

      t.timestamps
    end

    create_table :bookmarks, id: :uuid do |t|
      t.belongs_to :bookmark_folder, type: :uuid
      t.belongs_to :post, type: :uuid

      t.timestamps
    end
  end
end
