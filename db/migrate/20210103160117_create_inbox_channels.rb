class CreateInboxChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :inbox_channels, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.belongs_to :inbox, type: :uuid
      t.belongs_to :channel, type: :uuid
      t.json :settings

      t.timestamps
    end

    # An inbox cannot have the same channel multiple times
    add_index :inbox_channels, [:inbox_id, :channel_id], unique: true
  end
end
