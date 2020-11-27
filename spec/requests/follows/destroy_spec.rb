require 'rails_helper'

RSpec.describe :follows_destroy, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      delete follow_path(0)
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user does not own the resource' do
    it 'responds with not found' do
      user = create(:user)
      follow = create(:follow)

      delete follow_path(follow), headers: auth_headers_for(user)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user owns the resource' do
    it 'responds with the resource' do
      user = create(:user)
      follow = create(:follow, user: user)

      delete follow_path(follow), headers: auth_headers_for(user)

      expect(response).to have_http_status(:no_content)
    end
  end
end
