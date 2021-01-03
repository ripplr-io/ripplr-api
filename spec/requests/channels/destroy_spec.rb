require 'rails_helper'

RSpec.describe :channels_destroy, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { delete channel_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      channel = create(:channel)
      delete channel_path(channel), headers: auth_headers_for_new_user
    end
  end

  it 'responds without the resource' do
    user = create(:user)
    channel = create(:channel, user: user)

    delete channel_path(channel), headers: auth_headers_for(user)

    expect(response).to have_http_status(:no_content)
  end
end
