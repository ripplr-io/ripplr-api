require 'rails_helper'

RSpec.describe :communities_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post communities_path }
  end

  it_behaves_like :unprocessable_request, [:total_points] do
    let(:subject) do
      user = create(:prize, points: 100).user
      post communities_path, headers: auth_headers_for(user)
    end
  end

  it_behaves_like :unprocessable_request, [:name, :description, :community_topics] do
    let(:subject) do
      user = create(:prize, points: 1000).user
      post communities_path, headers: auth_headers_for(user)
    end
  end

  it 'responds with the community' do
    user = create(:prize, points: 1000).user
    topic = create(:topic)

    post communities_path,
      params: attributes_for(:community).slice(:name, :description).merge(topic_ids: [topic.id].to_json),
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Community.last)
  end
end
