require 'rails_helper'

RSpec.describe :devices_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      post devices_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      sign_in user
      mock_device = build(:device)

      post devices_path, as: :json, params: mock_device.as_json(only: [:name, :onesignal_id]).merge!(
        settings: mock_device.settings.to_json,
        type: mock_device.device_type
      )

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(Device.last)
    end

    it 'responds with errors' do
      user = create(:user)
      sign_in user

      post devices_path

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:name)
      expect(response_errors).to have_error(:settings)
    end
  end
end
