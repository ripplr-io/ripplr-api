require 'rails_helper'

RSpec.describe :bookmarks_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post bookmarks_path }
  end

  it_behaves_like :unprocessable_request, [:post, :bookmark_folder] do
    let(:subject) { post bookmarks_path, headers: auth_headers_for_new_user }
  end

  it 'responds with the resource' do
    user = create(:user)
    mock_bookmark = build(:bookmark, post: create(:post), bookmark_folder: create(:bookmark_folder, user: user))

    post bookmarks_path,
      params: mock_bookmark.as_json(only: [:post_id, :bookmark_folder_id]),
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(Bookmark.last)
  end
end
