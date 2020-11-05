require 'rails_helper'

RSpec.describe :auth_passwords_update, type: :request do
  it 'responds with the resource' do
    user = create(:user, password: '123456')
    token = user.send_reset_password_instructions

    put auth_password_path, params: {
      password: 'password',
      password_confirmation: 'password',
      reset_password_token: token
    }, as: :json

    expect(response).to have_http_status(:no_content) # TODO: return token info for instant login
    expect(user.reload.valid_password?('123456')).to be false
    expect(user.reload.valid_password?('password')).to be true
  end

  it 'responds with errors' do
    put auth_password_path, params: {
      password: 'password',
      password_confirmation: 'password'
    }, as: :json

    expect(response).to have_http_status(:unprocessable_entity)
  end
end
