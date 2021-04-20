require 'rails_helper'

RSpec.describe Trackers::TrackSignupWorker, type: :worker do
  it 'calls the service' do
    user = create(:user)

    expect(Analytics).to receive(:identify).with(user)
    expect(Analytics).to receive(:track).with(user, 'Signup')

    described_class.new.perform(user.id)
  end
end
