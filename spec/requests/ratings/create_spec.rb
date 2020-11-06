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
      ratable = create(:post)

      post post_ratings_path(ratable),
        params: { rate: 3 },
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(Rating.last)
    end

    it 'responds with errors' do
      user = create(:user)
      ratable = create(:post)

      post post_ratings_path(ratable), headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:points)
    end
  end
end
