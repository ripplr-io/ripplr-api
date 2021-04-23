require 'rails_helper'

RSpec.describe :followers_index, type: :request do
  it 'responds with the user followers' do
    user = create(:user)
    follow = create(:follow, followable: user)
    other_follow = create(:follow)

    get user_followers_path(user.profile), headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(follow.user)
    expect(response_data).not_to have_resource(other_follow.user)
  end
end
