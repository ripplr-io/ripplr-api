require 'rails_helper'

RSpec.describe :channels_index, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get channels_path }
  end

  it 'responds with the user resources' do
    user = create(:user)
    user_channel = create(:channel, user: user)
    other_channel = create(:channel)

    get channels_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user_channel)
    expect(response_data).not_to have_resource(other_channel)
    expect(response_included).to have_resource(user_channel.channelable)
  end
end
