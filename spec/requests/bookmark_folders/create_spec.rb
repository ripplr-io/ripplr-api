require 'rails_helper'

RSpec.describe :bookmark_folders_create, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      post bookmark_folders_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the resource' do
      user = create(:user)
      mock_bookmark_folder = build(:bookmark_folder)

      post bookmark_folders_path,
        params: mock_bookmark_folder.as_json(only: [:name, :bookmark_folder_id]),
        headers: auth_headers_for(user)

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(BookmarkFolder.last)
    end

    it 'responds with errors' do
      user = create(:user)

      post bookmark_folders_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:name)
    end
  end
end
