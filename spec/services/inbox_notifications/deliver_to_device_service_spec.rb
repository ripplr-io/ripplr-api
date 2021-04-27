require 'rails_helper'

RSpec.describe InboxNotifications::DeliverToDeviceService, type: :service do
  it 'builds a onesignal notification' do
    inbox_notification = create(:inbox_notification)
    service = described_class.new(inbox_notification)
    notification = service.instance_variable_get(:@notification)

    expected_title = "#{inbox_notification.inbox_item.inboxable.author.name} has shared a new post"
    expected_body = inbox_notification.inbox_item.inboxable.body
    expected_onesignal_id = inbox_notification.inbox_channel.channel.channel_device.onesignal_id

    expect(notification).not_to be nil
    expect(notification.is_a?(OneSignal::Notification)).to be true
    expect(notification.headings.en).to eq expected_title
    expect(notification.contents.en).to eq expected_body
    expect(notification.included_targets.include_player_ids).to include expected_onesignal_id
  end

  describe '#deliver' do
    context 'success' do
      it 'sets delivered_at' do
        inbox_notification = create(:inbox_notification)

        stub_request(:post, /onesignal.com/).to_return(status: 200, body: '{}')
        stub_request(:get, /onesignal.com/).to_return(status: 200, body: '{}')

        described_class.new(inbox_notification).deliver

        expect(inbox_notification.reload.delivered_at).not_to eq nil
      end
    end

    context 'failure' do
      it 'raises an error' do
        inbox_notification = create(:inbox_notification)

        stub_request(:post, /onesignal.com/).to_return(status: 400, body: '{}')
        expect(Rails.logger).to receive(:error)

        described_class.new(inbox_notification).deliver
      end
    end
  end
end
