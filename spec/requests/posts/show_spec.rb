require 'rails_helper'

RSpec.describe :posts_show, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      get post_path(0)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      sign_in user
      post = create(:post)

      get post_path(post)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(post)
    end

    it 'responds with not found' do
      user = create(:user)
      sign_in user

      get post_path(0)

      expect(response).to have_http_status(:not_found)
    end
  end
end
