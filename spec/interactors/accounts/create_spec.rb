require 'rails_helper'

RSpec.describe Accounts::Create, type: :interactor do
  it 'creates the account' do
    level = create(:level)
    user = build(:user, level: nil, billing: nil)

    expect { described_class.call(resource: user) }
      .to change { User.count }.by(1)
      .and change { Billing.count }.by(1)
      .and change { Profile.count }.by(1)
      .and change { BookmarkFolder.count }.by(1)
      .and change { Channel.count }.by(1)
      .and change { Inbox.count }.by(1)

    expect(User.last.level).to eq(level)
    expect(User.last.billing).not_to eq(nil)
    expect(User.last.profile).not_to eq(nil)
    expect(Trackers::TrackSignupWorker.jobs.size).to eq(1)
    expect(Sendgrid::SyncUserWorker.jobs.size).to eq(1)
  end

  it 'creates a referral accepted notification' do
    level = create(:level)
    referral = create(:referral)
    user = build(:user, level: nil, billing: nil, referral: referral)

    expect { described_class.call(resource: user) }
      .to change { User.count }.by(1)
      .and change { BookmarkFolder.count }.by(1)
      .and change { Notifications::ReferralAccepted.count }.by(1)

    expect(User.last.referral).to eq(referral)
    expect(referral.reload.invitee).to eq(User.last)
    expect(Prizes::ReferralAcceptedWorker.jobs.size).to eq(1)
    expect(Alerts::ReferralAcceptedWorker.jobs.size).to eq(1)
    expect(Prizes::Onboarding::FirstReferralWorker.jobs.size).to eq(1)
  end
end
