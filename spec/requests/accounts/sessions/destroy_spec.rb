require 'rails_helper'

RSpec.describe :accounts_sessions_destroy, type: :request do
  it 'responds with no content' do
    post destroy_user_session_path

    expect(response).to have_http_status(:no_content)
  end
end
