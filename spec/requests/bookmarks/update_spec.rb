require 'rails_helper'

RSpec.describe :bookmarks_update, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      patch bookmark_path(0)
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user does not own the resource' do
    it 'responds with not found' do
      user = create(:user)
      bookmark = create(:bookmark)

      patch bookmark_path(bookmark), headers: auth_headers_for(user)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user owns the resource' do
    it 'responds with the resource' do
      user = create(:user)
      bookmark = create(:bookmark, user: user, bookmark_folder: user.root_bookmark_folder)
      new_folder = create(:bookmark_folder, bookmark_folder: user.root_bookmark_folder, user: user)

      patch bookmark_path(bookmark), params: { bookmark_folder_id: new_folder.id }, headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(bookmark)
    end

    it 'responds with errors' do
      user = create(:user)
      bookmark = create(:bookmark, user: user)

      patch bookmark_path(bookmark), params: { post_id: nil }, headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:post)
    end
  end
end
