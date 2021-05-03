require 'rails_helper'

RSpec.describe :followers_index, type: :request do
  it 'responds with the user followers' do
    profile = create(:profile)
    follow = create(:follow, followable: profile)
    other_follow = create(:follow)

    get user_followers_path(profile)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(follow.user.profile)
    expect(response_data).not_to have_resource(other_follow.user.profile)
  end
end
