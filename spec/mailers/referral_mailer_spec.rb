require 'rails_helper'

RSpec.describe ReferralMailer, type: :mailer do
  describe 'invite' do
    it 'renders the email' do
      referral = create(:referral)
      mail = ReferralMailer.with(referral: referral).invite

      expect(mail.subject).to eq "#{referral.inviter.name} has invited to join Ripplr"
      expect(mail.to).to eq [referral.email]
      expect(mail.from).to eq ['support@ripplr.io']
      expect(mail.body).to include 'Join Ripplr'
      expect(mail.body).to include "http://localhost:8080/auth/register?referral_id=#{referral.id}"
    end
  end
end
