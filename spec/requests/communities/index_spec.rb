require 'rails_helper'

RSpec.describe :communities_index, type: :request do
  it 'responds with the topic resources' do
    topic = create(:topic)
    topic_community = create(:community, topics: [topic])
    other_community = create(:community)

    get topic_communities_path(topic)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(topic_community)
    expect(response_data).not_to have_resource(other_community)
  end
end
