class CreateInboxItems < ActiveRecord::Migration[6.0]
  def change
    create_table :inbox_items, id: :uuid do |t|
      t.belongs_to :inbox, type: :uuid
      t.references :inboxable, type: :uuid, polymorphic: true

      t.timestamps
    end
  end
end
