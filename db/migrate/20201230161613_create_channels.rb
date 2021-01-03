class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.references :channelable, type: :uuid, polymorphic: true

      t.string :name, null: false
      t.json :settings, null: false

      t.timestamps
    end

    create_table :channel_devices, id: :uuid do |t|
      t.string :device_type, null: false
      t.string :onesignal_id, null: false
    end

    create_table :channel_emails, id: :uuid do |t|
    end

    # A user cannot have two channels with the same name
    add_index :channels, [:user_id, :name], unique: true
  end
end
