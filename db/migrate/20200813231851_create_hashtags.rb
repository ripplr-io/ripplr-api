class CreateHashtags < ActiveRecord::Migration[6.0]
  def change
    create_table :hashtags, id: :uuid do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :post_hashtags, id: :uuid do |t|
      t.belongs_to :post, type: :uuid
      t.belongs_to :hashtag, type: :uuid

      t.timestamps
    end

    add_index :hashtags, :name, unique: true
  end
end
