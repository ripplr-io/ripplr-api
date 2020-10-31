require 'rails_helper'

RSpec.describe TopicChannel, type: :channel do
  it 'subscribes without streams when no room is provided' do
    user = create(:user)
    stub_connection current_user: user

    subscribe

    expect(subscription).to be_confirmed
    expect(subscription).not_to have_streams
  end

  it 'subscribes to a stream when a room is provided' do
    user = create(:user)
    topic = create(:topic)
    stub_connection current_user: user

    subscribe(room: topic.id)

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_for(topic)
  end
end
