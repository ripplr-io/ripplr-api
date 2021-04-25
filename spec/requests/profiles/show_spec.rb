require 'rails_helper'

RSpec.describe :profiles_show, type: :request do
  it 'responds with the resource' do
    profile = create(:profile)

    get user_path(profile)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(profile.user)
  end

  it 'responds with not found' do
    get user_path(0)
    expect(response).to have_http_status(:not_found)
  end
end
