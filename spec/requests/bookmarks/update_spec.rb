require 'rails_helper'

RSpec.describe :bookmarks_update, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { patch bookmark_path(0) }
  end

  it_behaves_like :forbidden_request do
    let(:subject) do
      bookmark = create(:bookmark)
      patch bookmark_path(bookmark), headers: auth_headers_for_new_user
    end
  end

  it_behaves_like :unprocessable_request, [:post] do
    let(:subject) do
      bookmark = create(:bookmark)

      patch bookmark_path(bookmark),
        params: { post_id: nil },
        headers: auth_headers_for(bookmark.user)
    end
  end

  it 'responds with the resource' do
    user = create(:user)
    bookmark = create(:bookmark, user: user, bookmark_folder: user.root_bookmark_folder)
    new_folder = create(:bookmark_folder, bookmark_folder: user.root_bookmark_folder, user: user)

    patch bookmark_path(bookmark), params: { bookmark_folder_id: new_folder.id }, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(bookmark)
  end
end
