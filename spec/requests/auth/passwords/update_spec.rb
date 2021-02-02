require 'rails_helper'

RSpec.describe :auth_passwords_update, type: :request do
  it_behaves_like :unprocessable_request do
    let(:subject) do
      put auth_password_path, params: {
        password: 'password',
        password_confirmation: 'password'
      }, as: :json
    end
  end

  it 'responds with the resource' do
    user = create(:user, password: '123456')
    token = user.send(:set_reset_password_token)

    put auth_password_path, params: {
      password: 'password',
      password_confirmation: 'password',
      reset_password_token: token
    }, as: :json

    expect(response).to have_http_status(:no_content) # TODO: return token info for instant login
    expect(user.reload.valid_password?('123456')).to be false
    expect(user.reload.valid_password?('password')).to be true
  end
end
