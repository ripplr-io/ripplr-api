require 'rails_helper'

RSpec.describe Referrals::InviteMailer, type: :mailer do
  it 'triggers the email api request' do
    referral = create(:referral)
    mailer.perform(referral.id)

    expect(mailer.from).to eq 'support@ripplr.io'
    expect(mailer.template).to eq 'd-0fa884a3213d4f9bbf4e5cf4d50e803a'

    personalization = mailer.personalizations.first
    expect(personalization.to).to eq referral.email
    expect(personalization.data['inviter_name']).to eq referral.inviter.profile.name
    expect(personalization.data['sign_up_url']).to eq "http://localhost:8080/auth/register?referral_id=#{referral.id}"
  end
end
