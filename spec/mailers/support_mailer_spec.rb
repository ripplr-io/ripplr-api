require 'rails_helper'

RSpec.describe SupportMailer, type: :mailer do
  describe 'new_ticket' do
    it 'renders the email' do
      ticket = create(:ticket, :with_screenshots)
      mail = SupportMailer.with(ticket: ticket).new_ticket

      expect(mail.subject).to eq "New ticket: #{ticket.title}"
      expect(mail.to).to eq ['support@ripplr.io']
      expect(mail.from).to eq ['support@ripplr.io']
      expect(mail.html_part.body).to include 'New ticket'
      expect(mail.attachments.size).to eq 1
    end
  end

  describe 'account_deleted' do
    it 'renders the email' do
      user = create(:user)
      comment = 'Unique Comment'
      mail = SupportMailer.with(user: user, comment: comment).account_deleted

      expect(mail.subject).to eq "#{user.name} canceled the account"
      expect(mail.to).to eq ['support@ripplr.io']
      expect(mail.from).to eq ['support@ripplr.io']
      expect(mail.body).to include 'A Ripplr account has just been canceled'
      expect(mail.body).to include 'Unique Comment'
    end
  end
end
