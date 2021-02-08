require 'rails_helper'

RSpec.describe :inboxes_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch inbox_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      inbox = create(:inbox)
      patch inbox_path(inbox), headers: auth_headers_for_new_user
    end
  end

  it_behaves_like :unprocessable_request, [:name, :settings] do
    let(:subject) do
      inbox = create(:inbox)

      patch inbox_path(inbox),
        params: { name: nil, settings: nil },
        headers: auth_headers_for(inbox.user)
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    inbox = create(:inbox, user: user)

    patch inbox_path(inbox),
      params: inbox.as_json(only: [:name, :description]).merge(settings: inbox.settings.to_json),
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(inbox)
  end

  it 'updates inbox channels' do
    user = create(:user)
    inbox = create(:inbox, user: user)

    channel_a = create(:channel, user: user)
    channel_b = create(:channel, user: user)
    channel_c = create(:channel, user: user)

    inbox_channel_b = create(:inbox_channel, inbox: inbox, channel: channel_b, user: user)
    inbox_channel_c = create(:inbox_channel, inbox: inbox, channel: channel_c, user: user)

    patch inbox_path(inbox),
      params: inbox.as_json(only: [:name]).merge(
        settings: inbox.settings.to_json,
        inbox_channels_attributes: [
          { id: nil, channel_id: channel_a.id },
          { id: inbox_channel_b.id },
          { id: inbox_channel_c.id, _destroy: true }
        ]
      ),
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(inbox.reload)
    expect(inbox.channels).to include(channel_a) # Create
    expect(inbox.channels).to include(channel_b) # Update
    expect(inbox.channels).not_to include(channel_c) # Destroy
  end
end
