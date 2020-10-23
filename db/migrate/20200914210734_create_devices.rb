class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.string :name, null: false
      t.string :device_type, null: false
      t.string :onesignal_id, null: false
      t.json :settings, null: false

      t.timestamps
    end
  end
end
