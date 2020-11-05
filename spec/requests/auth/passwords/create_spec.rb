require 'rails_helper'

RSpec.describe :auth_passwords_create, type: :request do
  it 'sends an email' do
    user = create(:user)

    post auth_password_path, params: { email: user.email }, as: :json

    expect(response).to have_http_status(:created)
  end

  it 'responds with errors' do
    put auth_password_path

    expect(response).to have_http_status(:unprocessable_entity)
  end
end
