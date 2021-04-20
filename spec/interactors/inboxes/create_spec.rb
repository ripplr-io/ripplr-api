require 'rails_helper'

RSpec.describe Inboxes::Create, type: :interactor do
  it 'creates the inbox' do
    inbox = build(:inbox)

    expect { described_class.call(resource: inbox) }
      .to change { Inbox.count }.by(1)

    expect(Trackers::TrackInboxCreatedWorker.jobs.size).to eq(1)
    expect(Prizes::Onboarding::FirstInboxWorker.jobs.size).to eq(1)
  end

  context 'level limit reached' do
    it 'does not create the inbox' do
      level = create(:level, inboxes: 2)
      user = create(:user, level: level)
      create_list(:inbox, 2, user: user)
      inbox = build(:inbox, user: user)

      expect { described_class.call(resource: inbox) }
        .to change { Inbox.count }.by(0)
    end
  end
end
