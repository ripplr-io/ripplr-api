require 'rails_helper'

RSpec.describe Mixpanel::TrackRatingCreatedWorker, type: :worker do
  it 'calls the mixpanel service' do
    rating = create(:rating)

    expect(Mixpanel::BaseService).to receive(:new).with(rating.user.id).and_call_original
    expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('Rating Created')

    described_class.new.perform(rating.id)
  end
end
