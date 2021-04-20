require 'rails_helper'

RSpec.describe :posts_previews_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post posts_previews_path }
  end

  it 'responds with data about the url' do
    expect(LinkPreview).to receive(:fetch).with('github.com').and_return({})

    post posts_previews_path(url: 'github.com'), headers: auth_headers_for_new_user

    expect(response).to have_http_status(:ok)
  end
end
