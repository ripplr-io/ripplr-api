require 'rails_helper'

RSpec.describe :inboxes_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post inboxes_path }
  end

  it_behaves_like :unprocessable_request, [:name, :settings] do
    let(:subject) { post inboxes_path, headers: auth_headers_for_new_user }
  end

  it 'responds with the resource' do
    mock_inbox = build(:inbox)

    post inboxes_path,
      params: mock_inbox.as_json(only: [:name]).merge(settings: mock_inbox.settings.to_json),
      headers: auth_headers_for_new_user

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Inbox.last)
  end

  it 'creates inbox channels' do
    channel = create(:channel)
    mock_inbox = build(:inbox)

    post inboxes_path,
      params: mock_inbox.as_json(only: [:name, :description]).merge(
        settings: mock_inbox.settings.to_json,
        inbox_channels_attributes: [
          { channel_id: channel.id }
        ]
      ),
      headers: auth_headers_for(channel.user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Inbox.last)
    expect(InboxChannel.last.inbox).to eq(Inbox.last)
    expect(InboxChannel.last.channel).to eq(Channel.last)
  end
end
