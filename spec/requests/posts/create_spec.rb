require 'rails_helper'

RSpec.describe :posts_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post posts_path }
  end

  it_behaves_like :unprocessable_request, [:title, :body, :url, :topic] do
    let(:subject) { post posts_path, headers: auth_headers_for_new_user }
  end

  it 'responds with the resource' do
    attributes = attributes_for(:post)
      .slice(:title, :body, :url)
      .merge(topic_id: create(:topic).id)

    post posts_path,
      params: attributes,
      headers: auth_headers_for_new_user

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Post.last)
  end

  context 'image' do
    it 'sets the image from file' do
      image = Rack::Test::UploadedFile.new(file_fixture('logo.png'))

      attributes = attributes_for(:post)
        .slice(:title, :body, :url)
        .merge(topic_id: create(:topic).id)
        .merge(image_file: image)

      post posts_path,
        params: attributes,
        headers: auth_headers_for_new_user

      expect(response).to have_http_status(:created)
      expect(Post.last.image.present?).to eq true
    end
  end

  context 'communities' do
    it 'sets the correct communities' do
      community = create(:community)
      other_community = create(:community)

      attributes = attributes_for(:post)
        .slice(:title, :body, :url)
        .merge(topic_id: create(:topic).id)
        .merge(community_ids: [community.id].to_json)

      post posts_path,
        params: attributes,
        headers: auth_headers_for_new_user

      expect(response).to have_http_status(:created)
      expect(Post.last.communities).to include(community)
      expect(Post.last.communities).not_to include(other_community)
    end
  end

  context 'hashtags' do
    it 'sets the correct hashtags' do
      hashtag = create(:hashtag)
      other_hashtag = create(:hashtag)

      attributes = attributes_for(:post)
        .slice(:title, :body, :url)
        .merge(topic_id: create(:topic).id)
        .merge(hashtags: [hashtag.name, 'newtag'].to_json)

      post posts_path,
        params: attributes,
        headers: auth_headers_for_new_user

      expect(response).to have_http_status(:created)
      expect(Post.last.hashtags).to include(hashtag)
      expect(Post.last.hashtags).not_to include(other_hashtag)

      new_tag = Hashtag.find_by(name: 'newtag')
      expect(new_tag).not_to eq(nil)
      expect(Post.last.hashtags).to include(new_tag)
    end
  end
end
