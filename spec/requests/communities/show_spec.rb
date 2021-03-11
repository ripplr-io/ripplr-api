require 'rails_helper'

RSpec.describe :communities_show, type: :request do
  it 'responds with the resource' do
    community = create(:community)

    get community_path(id: community.name)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(community)
  end

  it 'responds with not found' do
    get community_path(0)
    expect(response).to have_http_status(:not_found)
  end
end
