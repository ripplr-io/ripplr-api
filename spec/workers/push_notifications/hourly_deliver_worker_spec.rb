require 'rails_helper'

RSpec.describe PushNotifications::HourlyDeliverWorker, type: :worker do
  it 'enqueues workers to process push_notifications' do
    create_list(:push_notification, 2, scheduled_to: Time.current)

    described_class.new.perform

    expect(PushNotifications::DeliverWorker.jobs.size).to eq(2)
  end

  it 'ignores delivered push_notifications' do
    create(:push_notification, scheduled_to: Time.current, delivered_at: Time.current - 1.hour)

    described_class.new.perform

    expect(PushNotifications::DeliverWorker.jobs.size).to eq(0)
  end

  it 'ignores push_notifications scheduled before or after the current hour' do
    create(:push_notification, scheduled_to: Time.current - 2.hours)
    create(:push_notification, scheduled_to: Time.current + 2.hours)

    described_class.new.perform

    expect(PushNotifications::DeliverWorker.jobs.size).to eq(0)
  end
end
