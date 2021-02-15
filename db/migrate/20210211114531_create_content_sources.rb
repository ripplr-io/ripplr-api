class CreateContentSources < ActiveRecord::Migration[6.1]
  def change
    create_table :content_sources, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.belongs_to :topic, type: :uuid
      t.string :feed_url, null: false

      t.timestamps
    end
  end
end
