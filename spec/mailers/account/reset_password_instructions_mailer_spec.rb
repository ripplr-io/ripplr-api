require 'rails_helper'

RSpec.describe Account::ResetPasswordInstructionsMailer, type: :mailer do
  it 'triggers the email api request' do
    user = create(:user)
    token = user.send(:set_reset_password_token)
    reset_url = "http://localhost:8080/auth/password-reset?reset_password_token=#{token}"

    mailer.perform(user.id, token)

    expect(mailer.from).to eq 'support@ripplr.io'
    expect(mailer.template).to eq 'd-a2f8ac3963e4485686e9a314d5fd9a2f'

    personalization = mailer.personalizations.first
    expect(personalization.to).to eq user.email
    expect(personalization.data['password_reset_url']).to eq reset_url
  end
end
