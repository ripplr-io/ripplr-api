class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user
      t.references :subscribable, polymorphic: true
      t.json :settings, null: false

      t.timestamps
    end
  end
end
