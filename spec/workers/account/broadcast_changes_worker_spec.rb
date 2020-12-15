require 'rails_helper'

RSpec.describe Account::BroadcastChangesWorker, type: :worker do
  it 'broadcasts to the user channel' do
    user = create(:user)

    expect { described_class.new.perform(user.id) }
      .to have_broadcasted_to(user).from_channel(UserChannel)
  end
end
