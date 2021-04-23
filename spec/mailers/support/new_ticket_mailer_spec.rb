require 'rails_helper'

RSpec.describe Support::NewTicketMailer, type: :mailer do
  it 'triggers the email api request' do
    ticket = create(:ticket, :with_screenshots)
    mailer.perform(ticket.id)

    expect(mailer.from).to eq 'support@ripplr.io'
    expect(mailer.template).to eq 'd-46830b2e733847868987f734f2173e37'
    expect(mailer.reply_to).to eq ticket.user.email
    expect(mailer.attachments.size).to eq 1

    personalization = mailer.personalizations.first
    expect(personalization.to).to eq 'support@ripplr.io'
    expect(personalization.data['user_name']).to eq ticket.user.profile.name
    expect(personalization.data['user_email']).to eq ticket.user.email
    expect(personalization.data['reported_at']).to eq ticket.created_at.to_i
    expect(personalization.data['ticket_title']).to eq ticket.title
    expect(personalization.data['ticket_body']).to eq ticket.body
  end
end
