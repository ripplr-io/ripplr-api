class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :points, null: false, default: 0
      t.references :ratable, polymorphic: true
      t.belongs_to :user

      t.timestamps
    end
  end
end
