require 'rails_helper'

RSpec.describe :channels_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch channel_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      channel = create(:channel)
      patch channel_path(channel), headers: auth_headers_for_new_user
    end
  end

  it_behaves_like :unprocessable_request, [:name] do
    let(:subject) do
      channel = create(:channel)

      patch channel_path(channel),
        params: { name: nil },
        headers: auth_headers_for(channel.user)
    end
  end

  it 'responds with the resource (device)' do
    user = create(:user)
    channel = create(:channel, :for_device, user: user)

    patch channel_path(channel),
      params: channel.as_json(only: [:name]).merge(
        settings: channel.settings.to_json,
        channelable: channel.channelable.as_json(only: [:onesignal_id])
      ),
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(channel)
    expect(response_included).to have_resource(channel.channelable)
  end
end
