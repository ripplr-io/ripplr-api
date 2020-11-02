require 'rails_helper'

RSpec.describe :accounts_passwords_create, type: :request do
  it 'responds with the resource' do
    user = create(:user, password: '123456')
    token = user.send_reset_password_instructions

    post user_password_path, as: :json, params: {
      password: 'password',
      password_confirmation: 'password',
      token: token
    }

    expect(response).to have_http_status(:created)
    expect(user.reload.valid_password?('123456')).to be false
    expect(user.reload.valid_password?('password')).to be true
  end

  it 'responds with errors' do
    post user_password_path, as: :json, params: {
      password: 'password',
      password_confirmation: 'password'
    }

    expect(response).to have_http_status(:unprocessable_entity)
  end
end
