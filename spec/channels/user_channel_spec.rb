require 'rails_helper'

RSpec.describe UserChannel, type: :channel do
  it 'subscribes to the current_user stream' do
    user = create(:user)
    stub_connection current_user: user

    subscribe

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_for(user)
  end
end
