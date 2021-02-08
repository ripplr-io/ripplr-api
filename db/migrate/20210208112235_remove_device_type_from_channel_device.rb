class RemoveDeviceTypeFromChannelDevice < ActiveRecord::Migration[6.1]
  def change
    remove_column :channel_devices, :device_type
  end
end
