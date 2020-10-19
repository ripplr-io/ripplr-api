require 'rails_helper'

RSpec.describe :ratings_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      ratable = create(:post)
      post post_ratings_path(ratable)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      sign_in user
      ratable = create(:post)
      mock_rating = build(:rating, ratable: ratable)

      post post_ratings_path(ratable), as: :json, params: mock_rating.as_json(only: [:points])

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(Rating.last)
    end

    xit 'responds with errors' do
      # TODO: fix this scenario
      user = create(:user)
      sign_in user
      ratable = create(:post)

      post post_ratings_path(ratable)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:points)
    end
  end
end
