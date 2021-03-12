require 'rails_helper'

RSpec.describe Mixpanel::TrackCommunityCreatedWorker, type: :worker do
  it 'calls the mixpanel service' do
    community = create(:community)

    expect(Mixpanel::BaseService).to receive(:new).with(community.owner).and_call_original
    expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('Community Created')

    described_class.new.perform(community.id)
  end
end
