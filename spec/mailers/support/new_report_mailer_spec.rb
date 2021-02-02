require 'rails_helper'

RSpec.describe Support::NewReportMailer, type: :mailer do
  it 'triggers the email api request' do
    user = create(:user)
    post = create(:post)
    mailer.perform(user.id, post.id, 'Reason', 'Body')

    expect(mailer.from).to eq 'support@ripplr.io'
    expect(mailer.template).to eq 'd-d411ada772df468dba44701f43ec79b4'

    personalization = mailer.personalizations.first
    expect(personalization.to).to eq 'support@ripplr.io'
    expect(personalization.data['user_name']).to eq user.name
    expect(personalization.data['user_email']).to eq user.email
    expect(personalization.data['reported_at']).not_to eq nil
    expect(personalization.data['report_reason']).to eq 'Reason'
    expect(personalization.data['report_body']).to eq 'Body'
    expect(personalization.data['post_url']).to eq app_post_url(post)
  end
end
