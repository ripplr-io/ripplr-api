require 'rails_helper'

RSpec.describe :subscriptions_index, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      get subscriptions_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the user resources' do
      user = create(:user)
      user_subscription = create(:subscription, user: user)
      other_subscription = create(:subscription)

      get subscriptions_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user_subscription)
      expect(response_data).not_to have_resource(other_subscription)
    end
  end
end
