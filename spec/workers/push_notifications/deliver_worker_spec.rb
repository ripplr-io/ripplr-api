require 'rails_helper'

RSpec.describe PushNotifications::DeliverWorker, type: :worker do
  context 'push_notification was delivered' do
    it 'skips execution' do
      push_notification = create(:push_notification, delivered_at: Time.current)

      expect(PushNotifications::DeliverService).not_to receive(:new)

      described_class.new.perform(push_notification.id)
    end
  end

  context 'push_notification was scheduled for later' do
    it 'skips execution' do
      push_notification = create(:push_notification, scheduled_to: Time.current + 30.minutes)

      expect(PushNotifications::DeliverService).not_to receive(:new)

      described_class.new.perform(push_notification.id)
    end
  end

  context 'push_notification is sent' do
    it 'sets delivered_at' do
      push_notification = create(:push_notification, scheduled_to: Time.current - 30.minutes)

      expect(PushNotifications::DeliverService).to receive(:new).and_call_original
      allow_any_instance_of(PushNotifications::DeliverService).to receive(:deliver).and_return(true)

      described_class.new.perform(push_notification.id)

      expect(push_notification.reload.delivered_at).not_to be nil
    end
  end

  context 'push_notification fails to send' do
    it 'does not set delivered_at' do
      push_notification = create(:push_notification, scheduled_to: Time.current - 30.minutes)

      expect(PushNotifications::DeliverService).to receive(:new).and_call_original
      allow_any_instance_of(PushNotifications::DeliverService).to receive(:deliver).and_return(false)

      described_class.new.perform(push_notification.id)

      expect(push_notification.reload.delivered_at).to be nil
    end
  end
end
