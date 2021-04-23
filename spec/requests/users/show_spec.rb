require 'rails_helper'

RSpec.describe :users_show, type: :request do
  it 'responds with the resource' do
    user = create(:user)

    get user_path(user.profile)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user)
  end

  it 'responds with not found' do
    get user_path(0)
    expect(response).to have_http_status(:not_found)
  end
end
