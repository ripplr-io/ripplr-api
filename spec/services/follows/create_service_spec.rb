require 'rails_helper'

RSpec.describe Follows::CreateService, type: :service do
  it 'creates the follow' do
    follow = build(:follow, followable: create(:user))

    expect { described_class.new(follow).save }
      .to change { Follow.count }.by(1)
      .and change { Notifications::NewFollower.count }.by(1)

    expect(Mixpanel::TrackFollowCreatedWorker.jobs.size).to eq(1)
    expect(Prizes::Onboarding::FirstFollowWorker.jobs.size).to eq(1)
  end
end
