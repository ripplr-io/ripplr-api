require 'rails_helper'

RSpec.describe :follows_destroy, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { delete follow_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      follow = create(:follow)
      delete follow_path(follow), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    follow = create(:follow, user: user)

    delete follow_path(follow), headers: auth_headers_for(user)

    expect(response).to have_http_status(:no_content)
  end
end
