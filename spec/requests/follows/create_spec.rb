require 'rails_helper'

RSpec.describe :follows_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      post follows_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      followable = create(:user)
      mock_follow = build(:follow, followable: followable)

      post follows_path,
        params: mock_follow.as_json(only: [:followable_id, :followable_type]),
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(Follow.last)
    end

    it 'responds with errors' do
      user = create(:user)

      post follows_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:followable)
    end
  end
end
