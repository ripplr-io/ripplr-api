class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings, id: :uuid do |t|
      t.integer :points, null: false, default: 0
      t.references :ratable, type: :uuid, polymorphic: true
      t.belongs_to :user, type: :uuid

      t.timestamps
    end
  end
end
