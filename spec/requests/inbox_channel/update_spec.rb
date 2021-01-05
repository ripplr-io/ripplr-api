require 'rails_helper'

RSpec.describe :inbox_channels_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch inbox_channel_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      inbox_channel = create(:inbox_channel)
      patch inbox_channel_path(inbox_channel), headers: auth_headers_for_new_user
    end
  end

  it_behaves_like :unprocessable_request, [:inbox, :channel, :user] do
    let(:subject) do
      inbox_channel = create(:inbox_channel)

      patch inbox_channel_path(inbox_channel),
        params: { inbox_id: nil, channel_id: nil },
        headers: auth_headers_for(inbox_channel.user)
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    inbox_channel = create(:inbox_channel, user: user)

    patch inbox_channel_path(inbox_channel),
      params: { settings: inbox_channel.settings.to_json },
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(inbox_channel)
  end
end
