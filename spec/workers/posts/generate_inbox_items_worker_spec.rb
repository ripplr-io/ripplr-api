require 'rails_helper'

RSpec.describe Posts::GenerateInboxItemsWorker, type: :worker do
  it 'creates inbox items' do
    post = create(:post)
    inbox = create(:inbox)

    expect { described_class.new.perform(post.id) }
      .to change { Inbox::Item.count }.by(0)

    create(:subscription, user: inbox.user, subscribable: post.author, inboxes: [inbox])

    expect { described_class.new.perform(post.id) }
      .to change { Inbox::Item.count }.by(1)

    expect(Inbox::Item.last.inbox).to eq(inbox)
    expect(Inbox::Item.last.inboxable).to eq(post)
  end

  it 'filters topics' do
    topic = create(:topic)
    other_topic = create(:topic)

    inbox = create(:inbox, settings: {
      topics: {
        value: 'only',
        only: [topic.id]
      }
    }.as_json)

    author = create(:user)
    create(:subscription, user: inbox.user, subscribable: author, inboxes: [inbox])

    post = create(:post, author: author, topic: topic)
    other_post = create(:post, author: author, topic: other_topic)

    expect { described_class.new.perform(post.id) }
      .to change { Inbox::Item.count }.by(1)

    expect { described_class.new.perform(other_post.id) }
      .to change { Inbox::Item.count }.by(0)
  end
end
