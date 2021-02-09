class AddInboxAndChannelToExistingUsers < ActiveRecord::Migration[6.1]
  def change
    User.all.each do |user|
      user.inboxes.find_or_create_by(name: 'Main Inbox')
      user.channels.find_or_create_by(name: 'Email') do |channel|
        channel.channelable = Channel::Email.new
      end
    end
  end
end
