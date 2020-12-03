require 'rails_helper'

RSpec.describe :posts_previews_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post posts_previews_path }
  end

  it 'responds with data about the url' do
    stub_request(:get, /github.com/).to_return(status: 200, body: %(
      <html>
        <head>
          <title>Github</title>
          <meta name="description" content="#1 Open Source Repositories">
          <meta property="og:image" content="https://github.githubassets.com/images/modules/logos_page/Octocat.png">
        </head>
      </html>
    ))

    user = create(:user)

    post posts_previews_path(url: 'github.com'), headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data[:title]).to eq 'Github'
    expect(response_data[:body]).to eq '#1 Open Source Repositories'
    expect(response_data[:image]).to eq 'https://github.githubassets.com/images/modules/logos_page/Octocat.png'
    expect(response_data[:url]).to eq 'http://github.com/'
  end

  it 'responds with not found' do
    user = create(:user)

    post posts_previews_path(url: nil), headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data[:url]).to eq ''
  end
end
