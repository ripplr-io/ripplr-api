require 'rails_helper'

RSpec.describe :follows_index, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get follows_path }
  end

  it 'responds with the current user follows' do
    user = create(:user)
    user_follow = create(:follow, user: user)
    other_follow = create(:follow)

    get follows_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user_follow)
    expect(response_data).not_to have_resource(other_follow)
  end

  it 'responds with the user follows' do
    user = create(:user)
    user_follow = create(:follow, user: user)
    other_follow = create(:follow)

    get user_follows_path(user), headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user_follow)
    expect(response_data).not_to have_resource(other_follow)
  end
end
