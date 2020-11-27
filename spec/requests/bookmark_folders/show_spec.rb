require 'rails_helper'

RSpec.describe :bookmark_folders_show, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      get bookmark_folder_path(0)
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the root_bookmark_folder' do
      user = create(:user)
      folder = create(:bookmark_folder, bookmark_folder: user.root_bookmark_folder, user: user)

      get bookmark_folder_path(folder), headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(folder)
    end
  end
end
