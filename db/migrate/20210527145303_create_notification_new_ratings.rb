class CreateNotificationNewRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :notification_new_ratings, id: :uuid do |t|
      t.references :ratable, type: :uuid, polymorphic: true

      t.timestamps
    end
  end
end
