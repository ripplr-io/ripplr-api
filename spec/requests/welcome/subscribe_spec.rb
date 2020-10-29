require 'rails_helper'

RSpec.describe :welcome_subscribe, type: :request do
  it 'responds with ok' do
    stub_request(:post, /api.mailchimp.com/)
    post subscribe_path

    expect(response).to have_http_status(:ok)
  end
end