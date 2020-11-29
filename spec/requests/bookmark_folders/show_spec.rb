require 'rails_helper'

RSpec.describe :bookmark_folders_show, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get bookmark_folder_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      bookmark_folder = create(:bookmark_folder)
      get bookmark_folder_path(bookmark_folder), headers: auth_headers_for_new_user
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    bookmark_folder = create(:bookmark_folder, bookmark_folder: user.root_bookmark_folder, user: user)

    get bookmark_folder_path(bookmark_folder), headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(bookmark_folder)
  end
end
