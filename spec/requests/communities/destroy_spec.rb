require 'rails_helper'

RSpec.describe :communities_destroy, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { delete community_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      community = create(:community)
      delete community_path(community), headers: auth_headers_for_new_user
    end
  end

  it 'responds with no_content' do
    community = create(:community)

    delete community_path(community), headers: auth_headers_for(community.owner)

    expect(response).to have_http_status(:no_content)
  end
end
