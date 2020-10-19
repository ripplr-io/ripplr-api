require 'rails_helper'

RSpec.describe :subscriptions_update, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      patch subscription_path(0)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user does not own the resource' do
    it 'responds with not found' do
      user = create(:user)
      sign_in user
      subscription = create(:subscription)

      patch subscription_path(subscription)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user owns the resource' do
    it 'responds with the resource' do
      user = create(:user)
      sign_in user
      subscription = create(:subscription, user: user)

      patch subscription_path(subscription), as: :json, params: subscription.as_json(only: [
        :subscribable_id,
        :subscribable_type
      ]).merge!(
        settings: subscription.settings.to_json
      )

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(subscription)
    end

    it 'responds with errors' do
      user = create(:user)
      sign_in user
      subscription = create(:subscription, user: user)

      patch subscription_path(subscription), as: :json, params: { subscribable_id: nil }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:subscribable)
    end
  end
end
