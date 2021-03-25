require 'rails_helper'

RSpec.describe InboxNotifications::DeliverMailer, type: :mailer do
  it 'triggers the email api request' do
    channel = create(:channel, :for_email)
    inbox_channel = create(:inbox_channel, channel: channel, user: channel.user)
    inbox_notification = create(:inbox_notification, inbox_channel: inbox_channel)

    mailer.perform(inbox_notification.id)

    expect(mailer.from).to eq 'support@ripplr.io'
    expect(mailer.template).to eq 'd-b8526b810a5541c9ab28f1e826228529'

    personalization = mailer.personalizations.first
    expect(personalization.to).to eq inbox_notification.channel.user.email
  end

  it 'delivers the correct data' do
    author = create(:user, name: 'Author')
    topic = create(:topic, name: 'Topic')
    post = create(:post, author: author, topic: topic, title: 'Title', body: 'Body', url: 'http://google.com')

    user = create(:user)
    inbox = create(:inbox, user: user, name: 'Inbox')
    channel = create(:channel, :for_email, user: user)
    inbox_channel = create(:inbox_channel, user: user, inbox: inbox, channel: channel)

    inbox_item = create(:inbox_item, inbox: inbox, inboxable: post)
    inbox_notification = create(:inbox_notification, inbox_channel: inbox_channel, inbox_item: inbox_item)

    mailer.perform(inbox_notification.id)

    personalization = mailer.personalizations.first
    expect(personalization.data['inbox_name']).to eq 'Inbox'
    expect(personalization.data['inbox_url']).to eq "http://localhost:8080/inbox/#{inbox.id}"
    expect(personalization.data['author_name']).to eq 'Author'
    expect(personalization.data['author_url']).to eq 'http://localhost:8080/u/author'
    expect(personalization.data['topic_name']).to eq 'Topic'
    expect(personalization.data['topic_url']).to eq 'http://localhost:8080/t/topic'
    expect(personalization.data['post_title']).to eq 'Title'
    expect(personalization.data['post_image']).to eq Post::DEFAULT_IMAGE
    expect(personalization.data['post_body']).to eq 'Body'
    expect(personalization.data['post_url']).to eq 'http://google.com'
    expect(personalization.data['post_ripplr_url']).to eq "http://localhost:8080/p/#{post.id}"
  end

  it 'sets delivered_at' do
    channel = create(:channel, :for_email)
    inbox_channel = create(:inbox_channel, channel: channel, user: channel.user)
    inbox_notification = create(:inbox_notification, inbox_channel: inbox_channel)

    mailer.perform(inbox_notification.id)

    expect(inbox_notification.reload.delivered_at).not_to eq nil
  end
end
