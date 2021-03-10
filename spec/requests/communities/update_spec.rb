require 'rails_helper'

RSpec.describe :communities_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch community_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      community = create(:community)
      patch community_path(community), headers: auth_headers_for_new_user
    end
  end

  it_behaves_like :unprocessable_request, [:name, :description, :community_topics] do
    let(:subject) do
      community = create(:community)

      patch community_path(community),
        params: { name: nil, description: nil, topic_ids: [].to_json },
        headers: auth_headers_for(community.owner)
    end
  end

  it 'responds with the resource' do
    community = create(:community)

    patch community_path(community),
      params: attributes_for(:community).slice(:name, :description),
      headers: auth_headers_for(community.owner)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(community)
  end
end
