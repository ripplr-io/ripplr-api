class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.references :subscribable, type: :uuid, polymorphic: true
      t.json :settings, null: false

      t.timestamps
    end
  end
end
