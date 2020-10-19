require 'rails_helper'

RSpec.describe :hashtags_show, type: :request do
  it 'responds with the resource' do
    hashtag = create(:hashtag)

    get hashtag_path(id: hashtag.name)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(hashtag)
  end

  it 'responds with not found' do
    get hashtag_path(0)
    expect(response).to have_http_status(:not_found)
  end
end
