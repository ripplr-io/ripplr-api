require 'rails_helper'

RSpec.describe Segment::TrackRatingCreatedWorker, type: :worker do
  it 'calls the service' do
    rating = create(:rating)

    expect_any_instance_of(Segment::TrackService).to receive(:call).with(rating.user, 'Rating Created')

    described_class.new.perform(rating.id)
  end
end
