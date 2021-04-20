require 'rails_helper'

RSpec.describe Trackers::TrackCommunityCreatedWorker, type: :worker do
  it 'calls the service' do
    community = create(:community)

    expect(Analytics).to receive(:track).with(community.owner, 'Community Created')

    described_class.new.perform(community.id)
  end
end
