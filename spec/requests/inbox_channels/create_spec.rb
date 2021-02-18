require 'rails_helper'

RSpec.describe :inbox_channels_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post inbox_channels_path }
  end

  it_behaves_like :unprocessable_request, [:inbox, :channel, :user] do
    let(:subject) { post inbox_channels_path, headers: auth_headers_for_new_user }
  end

  it 'responds with the resource' do
    user = create(:user)
    inbox = create(:inbox, user: user)
    channel = create(:channel, user: user)
    mock_inbox_channel = build(:inbox_channel)

    post inbox_channels_path,
      params: {
        settings: mock_inbox_channel.settings.to_json,
        inbox_id: inbox.id,
        channel_id: channel.id
      },
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(InboxChannel.last)
  end
end
