require 'rails_helper'

RSpec.describe PushNotifications::DeliverService, type: :service do
  it 'builds a onesignal notification' do
    push_notification = create(:push_notification)
    service = described_class.new(push_notification)
    notification = service.instance_variable_get(:@notification)

    expect(notification).not_to be nil
    expect(notification.is_a?(OneSignal::Notification)).to be true
    expect(notification.headings.en).to eq push_notification.title
    expect(notification.contents.en).to eq push_notification.body
    expect(notification.included_targets.include_player_ids).to include push_notification.device.onesignal_id
  end

  describe '#deliver' do
    context 'success' do
      it 'returns true' do
        push_notification = create(:push_notification)
        service = described_class.new(push_notification)

        stub_request(:post, /onesignal.com/).to_return(status: 200, body: '{}')
        stub_request(:get, /onesignal.com/).to_return(status: 200, body: '{}')

        expect(service.deliver).to be true
      end
    end

    context 'failure' do
      it 'returns false' do
        push_notification = create(:push_notification)
        service = described_class.new(push_notification)

        stub_request(:post, /onesignal.com/).to_return(status: 400, body: '{}')

        expect(Rails.logger).to receive(:error)
        expect(service.deliver).to be false
      end
    end
  end
end
