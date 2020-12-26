require 'rails_helper'

RSpec.describe :inboxes_show, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get inbox_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      inbox = create(:inbox)
      get inbox_path(inbox), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    inbox = create(:inbox, user: user)

    get inbox_path(inbox), headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(inbox)
  end
end
