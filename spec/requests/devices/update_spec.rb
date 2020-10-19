require 'rails_helper'

RSpec.describe :devices_update, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      patch device_path(0)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user does not own the resource' do
    it 'responds with not found' do
      user = create(:user)
      sign_in user
      device = create(:device)

      patch device_path(device)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user owns the resource' do
    it 'responds with the resource' do
      user = create(:user)
      sign_in user
      device = create(:device, user: user)

      patch device_path(device), as: :json, params: device.as_json(only: [:name, :onesignal_id]).merge!(
        settings: device.settings.to_json,
        type: device.device_type
      )

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(device)
    end

    it 'responds with errors' do
      user = create(:user)
      sign_in user
      device = create(:device, user: user)

      patch device_path(device), as: :json, params: { name: nil }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:name)
    end
  end
end
