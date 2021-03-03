require 'rails_helper'

RSpec.describe Prizes::Onboarding::FirstInboxWorker, type: :worker do
  context 'the user has no inboxes' do
    it 'does not create a new prize' do
      user = create(:user)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(0)
    end
  end

  context 'the user has the main inbox' do
    it 'does not create a new prize' do
      user = create(:user)
      create(:inbox, name: 'Main Inbox', user: user)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(0)
    end
  end

  context 'the user has new inboxes' do
    it 'creates a new prize' do
      user = create(:user)
      create(:inbox, user: user, name: 'New Inbox')

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(1)

      new_prize = Prize.last
      expect(new_prize.name).to eq('First Inbox')
      expect(new_prize.points).to eq(150)
      expect(new_prize.prizable).to eq(nil)
      expect(new_prize.user).to eq(user)
      expect(Account::BroadcastChangesWorker.jobs.size).to eq(1)
    end

    it 'is idempotent' do
      user = create(:user)
      create(:inbox, user: user, name: 'New Inbox')

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(1)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(0)
    end
  end
end
