require 'rails_helper'

RSpec.describe :communities_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post communities_path }
  end

  it_behaves_like :unprocessable_request, [:name, :description, :community_topics] do
    let(:subject) do
      post communities_path, headers: auth_headers_for_new_user
    end
  end

  it 'responds with the community' do
    topic = create(:topic)

    post communities_path,
      params: attributes_for(:community).slice(:name, :description).merge(topic_ids: [topic.id].to_json),
      headers: auth_headers_for_new_user

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Community.last)
  end
end
