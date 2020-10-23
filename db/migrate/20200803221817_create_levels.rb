class CreateLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :levels, id: :uuid do |t|
      t.string :name, null: false
      t.integer :from, null: false
      t.integer :to, null: false
      t.integer :posts, null: false
      t.integer :referrals, null: false
      t.integer :subscriptions, null: false

      t.timestamps
    end
  end
end
