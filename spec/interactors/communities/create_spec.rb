require 'rails_helper'

RSpec.describe Communities::Create, type: :interactor do
  it 'creates the community' do
    owner = create(:prize, points: 1000).user
    community = build(:community, owner: owner)

    expect { described_class.call(resource: community) }
      .to change { Community.count }.by(1)

    expect(Trackers::TrackCommunityCreatedWorker.jobs.size).to eq(1)
  end
end
