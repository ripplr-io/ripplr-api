require 'rails_helper'

RSpec.describe Support::AccountDeletedMailer, type: :mailer do
  it 'triggers the email api request' do
    data = {
      user_name: 'Name',
      user_email: 'email@example.com',
      posts_total: 10,
      points_total: 20,
      joined_at: Time.current.to_i,
      rates_received_total: 30,
      rates_given_total: 40,
      followers_total: 50,
      following_total: 60,
      subscriptions_total: 70,
      subscribers_total: 80
    }

    mailer.perform(data, 'Comment')

    expect(mailer.from).to eq 'support@ripplr.io'
    expect(mailer.template).to eq 'd-70de35e6e4ee44cfada474b906c65b63'

    personalization = mailer.personalizations.first
    expect(personalization.to).to eq 'support@ripplr.io'
    expect(personalization.data['user_name']).to eq 'Name'
    expect(personalization.data['user_email']).to eq 'email@example.com'
    expect(personalization.data['posts_total']).to eq 10
    expect(personalization.data['points_total']).to eq 20
    expect(personalization.data['joined_at']).not_to eq nil
    expect(personalization.data['rates_received_total']).to eq 30
    expect(personalization.data['rates_given_total']).to eq 40
    expect(personalization.data['followers_total']).to eq 50
    expect(personalization.data['following_total']).to eq 60
    expect(personalization.data['subscriptions_total']).to eq 70
    expect(personalization.data['subscribers_total']).to eq 80
  end
end
