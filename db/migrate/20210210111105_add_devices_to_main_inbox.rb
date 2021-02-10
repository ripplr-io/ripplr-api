class AddDevicesToMainInbox < ActiveRecord::Migration[6.1]
  def up
    Channel::Device.all.each do |device|
      inbox = device.channel.user.inboxes.find_by(name: 'Main Inbox')
      device.channel.user.inbox_channels.create(inbox: inbox, channel: device.channel)
    end
  end
end
