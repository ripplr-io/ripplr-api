require 'rails_helper'

RSpec.describe Follows::CreateService, type: :service do
  it 'creates the follow' do
    followable = create(:user)

    follow_params = {
      followable_id: followable.id,
      followable_type: 'User',
      user: create(:user)
    }

    expect { described_class.new(follow_params).save }
      .to change { Follow.count }.by(1)
      .and change { Notifications::NewFollower.count }.by(1)

    expect(Mixpanel::TrackFollowCreatedWorker.jobs.size).to eq(1)
  end
end
