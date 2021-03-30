require 'rails_helper'

RSpec.describe :follows_index, type: :request do
  it 'responds with all follows' do
    follows = create_list(:follow, 2)

    get follows_path

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(follows.first)
    expect(response_data).to have_resource(follows.second)
  end

  it 'responds with the current_user follows' do
    user = create(:user)
    user_follow = create(:follow, user: user)
    other_follow = create(:follow)

    get follows_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user_follow)
    expect(response_data).not_to have_resource(other_follow)
    expect(response_included).to have_resource(user_follow.followable)
  end

  it 'responds with the user follows' do
    user = create(:user)
    user_follow = create(:follow, user: user)
    other_follow = create(:follow)

    get user_follows_path(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user_follow)
    expect(response_data).not_to have_resource(other_follow)
    expect(response_included).to have_resource(user_follow.followable)
  end
end
