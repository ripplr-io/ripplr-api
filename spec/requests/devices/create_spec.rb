require 'rails_helper'

RSpec.describe :devices_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post devices_path }
  end

  it_behaves_like :unprocessable_request, [:name, :settings] do
    let(:subject) { post devices_path, headers: auth_headers_for_new_user }
  end

  it 'responds with the resource' do
    user = create(:user)
    mock_device = build(:device)

    post devices_path, params: mock_device.as_json(only: [:name, :onesignal_id]).merge(
      settings: mock_device.settings.to_json,
      type: mock_device.device_type
    ), headers: auth_headers_for(user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Device.last)
  end
end
