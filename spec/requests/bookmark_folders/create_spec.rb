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
      sign_in user
      mock_bookmark_folder = build(:bookmark_folder)

      post bookmark_folders_path, as: :json, params: mock_bookmark_folder.as_json(only: [:name, :bookmark_folder_id])

      expect(response).to have_http_status(:created)
      expect(response_data).to have_resource(BookmarkFolder.last)
    end

    it 'responds with errors' do
      user = create(:user)
      sign_in user

      post bookmark_folders_path

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:name)
    end
  end
end
