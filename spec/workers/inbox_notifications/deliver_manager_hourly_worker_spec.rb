require 'rails_helper'

RSpec.describe InboxNotifications::DeliverManagerHourlyWorker, type: :worker do
  it 'enqueues workers to process inbox_notifications' do
    create_list(:inbox_notification, 2, scheduled_to: Time.current)

    described_class.new.perform

    expect(InboxNotifications::DeliverWorker.jobs.size).to eq(2)
  end

  it 'ignores delivered inbox_notifications' do
    create(:inbox_notification, scheduled_to: Time.current, delivered_at: Time.current - 1.hour)

    described_class.new.perform

    expect(InboxNotifications::DeliverWorker.jobs.size).to eq(0)
  end

  it 'ignores inbox_notifications scheduled before or after the current hour' do
    create(:inbox_notification, scheduled_to: Time.current - 2.hours)
    create(:inbox_notification, scheduled_to: Time.current + 2.hours)

    described_class.new.perform

    expect(InboxNotifications::DeliverWorker.jobs.size).to eq(0)
  end
end
