require 'rails_helper'

RSpec.describe InboxNotifications::DeliverWorker, type: :worker do
  context 'inbox_notification was delivered' do
    it 'skips execution' do
      inbox_notification = create(:inbox_notification, delivered_at: Time.current)

      expect(InboxNotifications::DeliverService).not_to receive(:new)

      described_class.new.perform(inbox_notification.id)
    end
  end

  context 'inbox_notification was scheduled for later' do
    it 'skips execution' do
      inbox_notification = create(:inbox_notification, scheduled_to: Time.current + 30.minutes)

      expect(InboxNotifications::DeliverService).not_to receive(:new)

      described_class.new.perform(inbox_notification.id)
    end
  end

  context 'inbox_notification is sent' do
    it 'sets delivered_at' do
      inbox_notification = create(:inbox_notification, scheduled_to: Time.current - 30.minutes)

      expect(InboxNotifications::DeliverService).to receive(:new).and_call_original
      allow_any_instance_of(InboxNotifications::DeliverService).to receive(:deliver).and_return(true)

      described_class.new.perform(inbox_notification.id)

      expect(inbox_notification.reload.delivered_at).not_to be nil
    end
  end

  context 'inbox_notification fails to send' do
    it 'does not set delivered_at' do
      inbox_notification = create(:inbox_notification, scheduled_to: Time.current - 30.minutes)

      expect(InboxNotifications::DeliverService).to receive(:new).and_call_original
      allow_any_instance_of(InboxNotifications::DeliverService).to receive(:deliver).and_return(false)

      described_class.new.perform(inbox_notification.id)

      expect(inbox_notification.reload.delivered_at).to be nil
    end
  end
end
