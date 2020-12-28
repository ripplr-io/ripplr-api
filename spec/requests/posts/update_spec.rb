require 'rails_helper'

RSpec.describe :posts_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch post_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      mock_post = create(:post)
      patch post_path(mock_post), headers: auth_headers_for_new_user
    end
  end

  it_behaves_like :unprocessable_request, [:title] do
    let(:subject) do
      mock_post = create(:post)

      patch post_path(mock_post),
        params: { title: nil },
        headers: auth_headers_for(mock_post.author)
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    mock_post = create(:post, author: user)

    patch post_path(mock_post),
      params: mock_post.as_json(only: [:title, :body, :url, :topic_id]).merge(hashtags: ['hashtag'].to_json),
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(mock_post)
  end

  it 'updates the image' do
    image = Rack::Test::UploadedFile.new(file_fixture('logo.png'))
    user = create(:user)
    mock_post = create(:post, author: user)

    patch post_path(mock_post),
      params: { image_file: image },
      headers: auth_headers_for(user)

    expect(mock_post.reload.image.present?).to eq true
  end
end
