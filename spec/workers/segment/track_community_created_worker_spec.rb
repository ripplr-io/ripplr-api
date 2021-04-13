require 'rails_helper'

RSpec.describe Segment::TrackCommunityCreatedWorker, type: :worker do
  it 'calls the service' do
    community = create(:community)

    expect_any_instance_of(Segment::TrackService).to receive(:call).with(community.owner, 'Community Created')

    described_class.new.perform(community.id)
  end
end
