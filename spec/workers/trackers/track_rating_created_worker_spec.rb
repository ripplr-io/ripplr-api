require 'rails_helper'

RSpec.describe Trackers::TrackRatingCreatedWorker, type: :worker do
  it 'calls the service' do
    rating = create(:rating)

    expect(Analytics).to receive(:track).with(rating.user, 'Rating Created')

    described_class.new.perform(rating.id)
  end
end
