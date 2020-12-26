require 'rails_helper'

RSpec.describe :inboxes_destroy, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { delete inbox_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      inbox = create(:inbox)
      delete inbox_path(inbox), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    inbox = create(:inbox, user: user)

    delete inbox_path(inbox), headers: auth_headers_for(user)

    expect(response).to have_http_status(:no_content)
  end
end
