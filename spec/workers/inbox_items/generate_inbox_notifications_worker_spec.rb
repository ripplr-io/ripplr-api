require 'rails_helper'

RSpec.describe InboxItems::GenerateInboxNotificationsWorker, type: :worker do
  it 'creates inbox notifications' do
    inbox = create(:inbox)
    inbox_item = create(:inbox_item, inbox: inbox)

    expect { described_class.new.perform(inbox_item.id) }
      .to change { InboxNotification.count }.by(0)

    inbox_channel = create(:inbox_channel, user: inbox.user, inbox: inbox)

    expect { described_class.new.perform(inbox_item.id) }
      .to change { InboxNotification.count }.by(1)

    expect(InboxNotification.last.inbox_item).to eq(inbox_item)
    expect(InboxNotification.last.inbox_channel).to eq(inbox_channel)
    expect(InboxNotifications::ScheduleWorker.jobs.size).to eq(1)
  end
end
