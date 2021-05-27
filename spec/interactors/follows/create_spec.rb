require 'rails_helper'

RSpec.describe Follows::Create, type: :interactor do
  it 'creates the follow' do
    follow = build(:follow, followable: create(:profile))

    expect { described_class.call(resource: follow) }
      .to change { Follow.count }.by(1)
      .and change { Notification.count }.by(1)
      .and change { Notification::NewFollower.count }.by(1)

    expect(Trackers::TrackFollowCreatedWorker.jobs.size).to eq(1)
    expect(Prizes::Onboarding::FirstFollowWorker.jobs.size).to eq(1)
  end
end
