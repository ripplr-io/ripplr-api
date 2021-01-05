require 'rails_helper'

RSpec.describe :inbox_channels_destroy, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { delete inbox_channel_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      inbox_channel = create(:inbox_channel)
      delete inbox_channel_path(inbox_channel), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    inbox_channel = create(:inbox_channel)

    delete inbox_channel_path(inbox_channel), headers: auth_headers_for(inbox_channel.user)

    expect(response).to have_http_status(:no_content)
  end
end
