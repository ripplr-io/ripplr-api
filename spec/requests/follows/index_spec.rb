require 'rails_helper'

RSpec.describe :follows_index, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      get follows_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the user resources' do
      user = create(:user)
      user_follow = create(:follow, user: user)
      other_follow = create(:follow)

      get follows_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user_follow)
      expect(response_data).not_to have_resource(other_follow)
    end
  end
end
