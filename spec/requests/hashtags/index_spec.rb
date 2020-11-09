require 'rails_helper'

RSpec.describe :hashtags_index, type: :request do
  it 'responds with the resource' do
    hashtag_a = create(:hashtag, name: 'Query')
    hashtag_b = create(:hashtag, name: 'Other')

    get hashtags_path(query: 'Que')

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(hashtag_a)
    expect(response_data).not_to have_resource(hashtag_b)
  end
end
