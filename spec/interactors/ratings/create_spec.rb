require 'rails_helper'

RSpec.describe Ratings::Create, type: :interactor do
  it 'creates the rating' do
    rating = build(:rating)

    expect { described_class.call(resource: rating) }
      .to change { Rating.count }.by(1)

    expect(Users::UpdateLevelWorker.jobs.size).to eq(1)
    expect(Mixpanel::TrackRatingCreatedWorker.jobs.size).to eq(1)
    expect(Prizes::Onboarding::FirstRatingWorker.jobs.size).to eq(1)
  end

  it 'updates the rating' do
    rating = create(:rating, points: 5)
    new_rating = build(:rating, user: rating.user, ratable: rating.ratable, points: 8)

    expect { described_class.call(resource: new_rating) }
      .to change { Rating.count }.by(0)

    expect(Users::UpdateLevelWorker.jobs.size).to eq(1)
  end
end