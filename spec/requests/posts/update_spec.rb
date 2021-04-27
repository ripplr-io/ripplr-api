require 'rails_helper'

RSpec.describe :posts_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch post_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      post = create(:post)
      patch post_path(post), headers: auth_headers_for_new_user
    end
  end

  it_behaves_like :unprocessable_request, [:title, :body] do
    let(:subject) do
      post = create(:post)

      patch post_path(post),
        params: { title: nil, body: nil },
        headers: auth_headers_for(post.author.user)
    end
  end

  it 'responds with the resource' do
    post = create(:post)

    patch post_path(post),
      params: attributes_for(:post).slice(:title, :body),
      headers: auth_headers_for(post.author.user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(post)
  end

  context 'image' do
    it 'updates the image' do
      image = Rack::Test::UploadedFile.new(file_fixture('logo.png'))
      post = create(:post)

      patch post_path(post),
        params: { image_file: image },
        headers: auth_headers_for(post.author.user)

      expect(post.reload.image.present?).to eq true
    end
  end
end
