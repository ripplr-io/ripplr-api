require 'rails_helper'

RSpec.describe :subscriptions_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      post subscriptions_path
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      subscribable = create(:user)
      mock_subscription = build(:subscription, subscribable: subscribable)

      post subscriptions_path, params: mock_subscription.as_json(only: [
        :subscribable_id,
        :subscribable_type
      ]).merge(
        settings: mock_subscription.settings.to_json
      ), headers: auth_headers_for(user)

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(Subscription.last)
    end

    it 'responds with errors' do
      user = create(:user)

      post subscriptions_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:subscribable)
      expect(response_errors).to have_error(:settings)
    end
  end
end
