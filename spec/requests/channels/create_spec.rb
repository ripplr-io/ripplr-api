require 'rails_helper'

RSpec.describe :channels_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post channels_path }
  end

  it_behaves_like :unprocessable_request, [:name, :channelable] do
    let(:subject) { post channels_path, headers: auth_headers_for_new_user }
  end

  it 'responds with the resource (device)' do
    attributes = attributes_for(:channel).slice(:name, :settings).merge(
      channelable: attributes_for(:channel_device).slice(:onesignal_id)
    )

    post channels_path, params: attributes, headers: auth_headers_for_new_user

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Channel.last)
    expect(response_included).to have_resource(Channel.last.channelable)
  end
end
