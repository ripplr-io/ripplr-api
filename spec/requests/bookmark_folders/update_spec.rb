require 'rails_helper'

RSpec.describe :bookmark_folders_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch bookmark_folder_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      bookmark_folder = create(:bookmark_folder)
      patch bookmark_folder_path(bookmark_folder), headers: auth_headers_for_new_user
    end
  end

  it_behaves_like :unprocessable_request, [:name] do
    let(:subject) do
      bookmark_folder = create(:bookmark_folder)

      patch bookmark_folder_path(bookmark_folder),
        params: { name: nil },
        headers: auth_headers_for(bookmark_folder.user)
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    bookmark_folder = create(:bookmark_folder, user: user)

    patch bookmark_folder_path(bookmark_folder), params: bookmark_folder.as_json(only: [
      :name,
      :bookmark_folder_id
    ]), headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(bookmark_folder)
  end
end
