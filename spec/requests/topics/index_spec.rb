require 'rails_helper'

RSpec.describe :topics_index, type: :request do
  it 'responds with the resources' do
    topic_a = create(:topic)
    topic_b = create(:topic)

    get topics_path

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(topic_a)
    expect(response_data).to have_resource(topic_b)
  end
end
