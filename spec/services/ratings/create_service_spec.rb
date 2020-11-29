require 'rails_helper'

RSpec.describe Ratings::CreateService, type: :service do
  it 'creates the rating' do
    rating = build(:rating)

    expect { described_class.new(rating).save }
      .to change { Rating.count }.by(1)

    expect(Users::UpdateLevelWorker.jobs.size).to eq(1)
    expect(Mixpanel::TrackRatingCreatedWorker.jobs.size).to eq(1)
  end

  it 'updates the rating' do
    rating = create(:rating, points: 5)
    new_rating = build(:rating, user: rating.user, ratable: rating.ratable, points: 8)

    expect { described_class.new(new_rating).save }
      .to change { Rating.count }.by(0)

    expect(Users::UpdateLevelWorker.jobs.size).to eq(1)
  end
end
