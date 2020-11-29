require 'rails_helper'

RSpec.describe :bookmark_folders_create, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { post bookmark_folders_path }
  end

  it_behaves_like :unprocessable_request, [:name] do
    let(:subject) { post bookmark_folders_path, headers: auth_headers_for_new_user }
  end

  it 'responds with the resource' do
    user = create(:user)
    mock_bookmark_folder = build(:bookmark_folder)

    post bookmark_folders_path,
      params: mock_bookmark_folder.as_json(only: [:name, :bookmark_folder_id]),
      headers: auth_headers_for(user)

    expect(response).to have_http_status(:created)
    expect(response_data).to have_resource(BookmarkFolder.last)
  end
end
