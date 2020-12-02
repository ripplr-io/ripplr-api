require 'rails_helper'

RSpec.describe Prizes::Onboarding::FirstRatingWorker, type: :worker do
  context 'the user has no ratings' do
    it 'does not create a new prize' do
      user = create(:user)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(0)
    end
  end

  context 'the user has ratings' do
    it 'creates a new prize' do
      user = create(:user)
      create(:rating, user: user)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(1)

      new_prize = Prize.last
      expect(new_prize.name).to eq('First Rating')
      expect(new_prize.points).to eq(50)
      expect(new_prize.prizable).to eq(nil)
      expect(new_prize.user).to eq(user)
    end

    it 'is idempotent' do
      user = create(:user)
      create(:rating, user: user)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(1)

      expect { described_class.new.perform(user.id) }
        .to change { Prize.count }.by(0)
    end
  end
end
