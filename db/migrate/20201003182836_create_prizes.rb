class CreatePrizes < ActiveRecord::Migration[6.0]
  def change
    create_table :prizes do |t|
      t.belongs_to :user
      t.references :ratable, polymorphic: true

      t.integer :points, null: false
      t.string :name, null: false
      t.datetime :given_at

      t.timestamps
    end
  end
end
