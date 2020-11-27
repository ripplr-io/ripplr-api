require 'rails_helper'

RSpec.describe :bookmark_folders_destroy, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      delete bookmark_folder_path(0)
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user does not own the resource' do
    it 'responds with not found' do
      user = create(:user)
      bookmark_folder = create(:bookmark_folder)

      delete bookmark_folder_path(bookmark_folder), headers: auth_headers_for(user)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user owns the resource' do
    it 'responds with the resource' do
      user = create(:user)
      bookmark_folder = create(:bookmark_folder, user: user)

      delete bookmark_folder_path(bookmark_folder), headers: auth_headers_for(user)

      expect(response).to have_http_status(:no_content)
    end
  end
end
