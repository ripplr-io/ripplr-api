require 'rails_helper'

RSpec.describe :inboxes_index, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get inboxes_path }
  end

  it 'responds with the user resources' do
    user = create(:user)
    user_inbox = create(:inbox, user: user)
    other_inbox = create(:inbox)
    inbox_channel = create(:inbox_channel, inbox: user_inbox, user: user)

    get inboxes_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user_inbox)
    expect(response_data).not_to have_resource(other_inbox)
    expect(response_data).not_to have_resource(other_inbox)
    expect(response_included).to have_resource(inbox_channel)
  end
end
