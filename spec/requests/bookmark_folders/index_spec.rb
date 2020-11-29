require 'rails_helper'

RSpec.describe :bookmark_folders_index, type: :request do
  it_behaves_like :unauthenticated_request do
    let(:subject) { get bookmark_folders_path }
  end

  it 'responds with the root_bookmark_folder' do
    user = create(:user)

    get bookmark_folders_path, headers: auth_headers_for(user)

    expect(response).to have_http_status(:ok)
    expect(response_data).to have_resource(user.root_bookmark_folder)
  end
end
