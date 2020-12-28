require 'rails_helper'

RSpec.describe :posts_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post posts_path }
  end

  it_behaves_like :unprocessable_request, [:title, :body, :url, :topic] do
    let(:subject) { post posts_path, headers: auth_headers_for_new_user }
  end

  it 'responds with the resource' do
    user = create(:user)
    mock_post = build(:post, topic: create(:topic))

    post posts_path,
      params: mock_post.as_json(only: [:title, :body, :url, :topic_id]).merge(hashtags: ['hashtag'].to_json),
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Post.last)
  end

  it 'sets the image from file' do
    image = Rack::Test::UploadedFile.new(file_fixture('logo.png'))
    user = create(:user)
    mock_post = build(:post, topic: create(:topic))

    post posts_path,
      params: mock_post.as_json(only: [:title, :body, :url, :topic_id]).merge(image_file: image),
      headers: auth_headers_for(user)

    expect(Post.last.image.present?).to eq true
  end
end
