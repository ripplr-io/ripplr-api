require 'rails_helper'

RSpec.describe InboxNotifications::DeliverService, type: :service do
  context 'channel is a device' do
    it 'calls the DeliverToDeviceService' do
      channel = create(:channel, :for_device)
      inbox_channel = create(:inbox_channel, user: channel.user, channel: channel)
      inbox_notification = create(:inbox_notification, inbox_channel: inbox_channel)

      expect_any_instance_of(InboxNotifications::DeliverToDeviceService).to receive(:deliver).and_return(true)

      described_class.new(inbox_notification).deliver
    end
  end

  context 'channel is an email' do
    it 'calls the DeliverToEmailService' do
      channel = create(:channel, :for_email)
      inbox_channel = create(:inbox_channel, user: channel.user, channel: channel)
      inbox_notification = create(:inbox_notification, inbox_channel: inbox_channel)

      described_class.new(inbox_notification).deliver

      expect(InboxNotifications::DeliverMailer.jobs.size).to eq(1)
    end
  end
end
