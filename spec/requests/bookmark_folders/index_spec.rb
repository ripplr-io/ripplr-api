require 'rails_helper'

RSpec.describe :bookmark_folders_index, type: :request do
  context 'when the user is not authenticated' do
    it 'responds with not_found' do
      get bookmark_folders_path
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the user is authenticated' do
    it 'responds with the root_bookmark_folder' do
      user = create(:user)

      get bookmark_folders_path, headers: auth_headers_for(user)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_resource(user.root_bookmark_folder)
    end
  end
end
