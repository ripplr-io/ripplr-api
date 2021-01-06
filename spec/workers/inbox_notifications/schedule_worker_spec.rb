require 'rails_helper'

RSpec.describe InboxNotifications::ScheduleWorker, type: :worker do
  it 'sets the schedule_to value' do
    inbox_notification = create(:inbox_notification, scheduled_to: nil)

    described_class.new.perform(inbox_notification.id)

    expect(inbox_notification.reload.scheduled_to).not_to eq(nil)
  end
end
