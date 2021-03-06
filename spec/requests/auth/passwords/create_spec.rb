require 'rails_helper'

RSpec.describe :auth_passwords_create, type: :request do
  it_behaves_like :unprocessable_request do
    let(:subject) { post auth_password_path }
  end

  it 'sends an email' do
    user = create(:user)

    post auth_password_path, params: { email: user.email }, as: :json

    expect(response).to have_http_status(:created)
  end
end
