require 'rails_helper'

RSpec.describe :bookmark_folders_update, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with unauthorized' do
      patch bookmark_folder_path(0)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the user does not own the resource' do
    it 'responds with not found' do
      user = create(:user)
      sign_in user
      bookmark_folder = create(:bookmark_folder)

      patch bookmark_folder_path(bookmark_folder)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user owns the resource' do
    it 'responds with the resource' do
      user = create(:user)
      sign_in user
      bookmark_folder = create(:bookmark_folder, user: user)

      patch bookmark_folder_path(bookmark_folder), as: :json, params: bookmark_folder.as_json(only: [
        :name,
        :bookmark_folder_id
      ])

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(bookmark_folder)
    end

    it 'responds with errors' do
      user = create(:user)
      sign_in user
      bookmark_folder = create(:bookmark_folder, user: user)

      patch bookmark_folder_path(bookmark_folder), as: :json, params: { name: nil }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_errors).to have_error(:name)
    end
  end
end