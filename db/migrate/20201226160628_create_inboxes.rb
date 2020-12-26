class CreateInboxes < ActiveRecord::Migration[6.0]
  def change
    create_table :inboxes, id: :uuid do |t|
      t.belongs_to :user, type: :uuid

      t.string :name, null: false
      t.json :settings, null: false

      t.timestamps
    end

    create_table :subscription_inboxes, id: :uuid do |t|
      t.belongs_to :subscription, type: :uuid
      t.belongs_to :inbox, type: :uuid

      t.timestamps
    end
  end
end
