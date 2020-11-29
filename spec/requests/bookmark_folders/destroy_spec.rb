require 'rails_helper'

RSpec.describe :bookmark_folders_destroy, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { delete bookmark_folder_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      bookmark_folder = create(:bookmark_folder)
      delete bookmark_folder_path(bookmark_folder), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    bookmark_folder = create(:bookmark_folder, user: user)

    delete bookmark_folder_path(bookmark_folder), headers: auth_headers_for(user)

    expect(response).to have_http_status(:no_content)
  end
end
