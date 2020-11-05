require 'rails_helper'

RSpec.describe :posts_destroy, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      delete post_path(0)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user does not own the resource' do
    it 'responds with not found' do
      user = create(:user)
      mock_post = create(:post)

      delete post_path(mock_post), headers: auth_headers_for(user)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user owns the resource' do
    it 'responds with the resource' do
      user = create(:user)
      mock_post = create(:post, author: user)

      delete post_path(mock_post), headers: auth_headers_for(user)

      expect(response).to have_http_status(:no_content)
    end
  end
end
