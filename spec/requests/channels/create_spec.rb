require 'rails_helper'

RSpec.describe :channels_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post channels_path }
  end

  it_behaves_like :unprocessable_request, [:name, :settings, :channelable] do
    let(:subject) { post channels_path, headers: auth_headers_for_new_user }
  end

  it 'responds with the resource (device)' do
    user = create(:user)
    mock_device = build(:channel_device)
    mock_channel = mock_device.channel

    post channels_path,
      params: mock_channel.as_json(only: [:name]).merge(
        settings: mock_channel.settings.to_json,
        channel_device: mock_device.as_json(only: [:onesignal_id, :device_type])
      ),
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Channel.last)
    expect(response_included).to have_resource(Channel.last.channelable)
  end
end
