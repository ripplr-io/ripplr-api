require 'rails_helper'

RSpec.describe :bookmarks_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      post bookmarks_path
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      mock_bookmark = build(:bookmark, post: create(:post), bookmark_folder: create(:bookmark_folder, user: user))

      post bookmarks_path,
        params: mock_bookmark.as_json(only: [:post_id, :bookmark_folder_id]),
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(Bookmark.last)
    end

    it 'responds with errors' do
      user = create(:user)

      post bookmarks_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:post)
      expect(response_errors).to have_error(:bookmark_folder)
    end
  end
end
