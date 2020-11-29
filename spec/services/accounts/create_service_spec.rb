require 'rails_helper'

RSpec.describe Accounts::CreateService, type: :service do
  it 'creates the account' do
    level = create(:level)
    user = build(:user)

    expect { described_class.new(user).save }
      .to change { User.count }.by(1)
      .and change { BookmarkFolder.count }.by(1)

    expect(User.last.level).to eq(level)
    expect(Mixpanel::TrackSignupWorker.jobs.size).to eq(1)
  end

  it 'creates a referral accepted notification' do
    level = create(:level)
    referral = create(:referral)
    user = build(:user)

    expect { described_class.new(user, referral_id: referral.id).save }
      .to change { User.count }.by(1)
      .and change { BookmarkFolder.count }.by(1)
      .and change { Notifications::ReferralAccepted.count }.by(1)

    expect(User.last.level).to eq(level)
    expect(User.last.referral).to eq(referral)
    expect(referral.reload.invitee).to eq(User.last)
    expect(Prizes::ReferralAcceptedWorker.jobs.size).to eq(1)
  end
end
