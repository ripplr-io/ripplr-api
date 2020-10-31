require 'rails_helper'

RSpec.describe ProfileChannel, type: :channel do
  it 'subscribes without streams when no room is provided' do
    user = create(:user)
    stub_connection current_user: user

    subscribe

    expect(subscription).to be_confirmed
    expect(subscription).not_to have_streams
  end

  it 'subscribes to a stream when a room is provided' do
    user = create(:user)
    user_with_profile = create(:user)
    stub_connection current_user: user

    subscribe(room: user_with_profile.id)

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_for(user_with_profile)
  end
end
