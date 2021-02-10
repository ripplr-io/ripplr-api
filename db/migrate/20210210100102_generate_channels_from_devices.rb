class GenerateChannelsFromDevices < ActiveRecord::Migration[6.1]
  def up
    Device.all.each do |device|
      cd = Channel::Device.new(onesignal_id: device.onesignal_id)
      device.user.channels.create(name: device.name, settings: device.settings, channelable: cd)
    end
  end
end
