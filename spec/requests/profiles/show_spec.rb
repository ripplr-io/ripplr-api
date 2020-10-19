require 'rails_helper'

RSpec.describe :profiles_show, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      get '/auth/user'
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the user resource' do
      user = create(:user)
      sign_in user

      get '/auth/user'

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user)
    end
  end
end
