require 'rails_helper'

RSpec.describe InboxNotifications::DeliverService, type: :service do
  context 'channel is a device' do
    it 'calls the DeliverToDeviceService' do
      channel_device = create(:channel_device)
      inbox_channel = create(:inbox_channel, user: channel_device.channel.user, channel: channel_device.channel)
      inbox_notification = create(:inbox_notification, inbox_channel: inbox_channel)

      expect_any_instance_of(InboxNotifications::DeliverToDeviceService).to receive(:deliver).and_return(true)

      described_class.new(inbox_notification).deliver
    end
  end

  xcontext 'channel is an email' do
    it 'calls the DeliverToEmailService' do
      channel_email = create(:channel_email)
      inbox_channel = create(:inbox_channel, user: channel_email.channel.user, channel: channel_email.channel)
      inbox_notification = create(:inbox_notification, inbox_channel: inbox_channel)

      expect_any_instance_of(InboxNotifications::DeliverToEmailService).to receive(:deliver).and_return(true)

      described_class.new(inbox_notification).deliver
    end
  end

  context 'channel is any other type' do
    it 'returns false' do
      inbox_notification = create(:inbox_notification)
      inbox_notification.channel.channelable_type = nil

      expect(described_class.new(inbox_notification).deliver).to eq(false)
    end
  end
end
