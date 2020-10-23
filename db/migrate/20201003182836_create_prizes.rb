class CreatePrizes < ActiveRecord::Migration[6.0]
  def change
    create_table :prizes, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.references :prizable, type: :uuid, polymorphic: true

      t.integer :points, null: false
      t.string :name, null: false
      t.datetime :given_at

      t.timestamps
    end
  end
end
