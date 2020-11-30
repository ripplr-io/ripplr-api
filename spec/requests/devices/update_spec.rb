require 'rails_helper'

RSpec.describe :devices_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch device_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      device = create(:device)
      patch device_path(device), headers: auth_headers_for_new_user
    end
  end

  it_behaves_like :unprocessable_request, [:name] do
    let(:subject) do
      device = create(:device)

      patch device_path(device),
        params: { name: nil },
        headers: auth_headers_for(device.user)
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    device = create(:device, user: user)

    patch device_path(device), params: device.as_json(only: [:name, :onesignal_id]).merge(
      settings: device.settings.to_json,
      type: device.device_type
    ), headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(device)
  end
end
