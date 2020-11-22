require 'rails_helper'

RSpec.describe Ratings::CreateService, type: :service do
  it 'creates the rating' do
    user = create(:user)
    post = create(:post)

    expect { described_class.new(user, post, 8).save }
      .to change { Rating.count }.by(1)

    expect(Users::UpdateLevelWorker.jobs.size).to eq(1)
    expect(Mixpanel::TrackRatingCreatedWorker.jobs.size).to eq(1)
  end

  it 'updates the rating' do
    rating = create(:rating, points: 5)

    expect { described_class.new(rating.user, rating.ratable, 8).save }
      .to change { Rating.count }.by(0)

    expect(Users::UpdateLevelWorker.jobs.size).to eq(1)
  end
end
