require 'rails_helper'

RSpec.describe Prizes::CreateService, type: :service do
  it 'creates the prize' do
    referral = create(:referral)

    prize_params = {
      prizable: referral,
      user: referral.inviter,
      name: 'Name',
      points: 15
    }

    expect { described_class.new(prize_params).save }
      .to change { Prize.count }.by(1)

    expect(Users::UpdateLevelWorker.jobs.size).to eq(1)
  end
end
