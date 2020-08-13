class CreateHashtags < ActiveRecord::Migration[6.0]
  def change
    create_table :hashtags do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :post_hashtags do |t|
      t.belongs_to :post
      t.belongs_to :hashtag
    end

    add_index :hashtags, :name, unique: true
  end
end
