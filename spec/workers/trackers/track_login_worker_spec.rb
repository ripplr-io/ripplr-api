require 'rails_helper'

RSpec.describe Trackers::TrackLoginWorker, type: :worker do
  it 'calls the service' do
    user = create(:user)

    expect(Analytics).to receive(:identify).with(user)
    expect(Analytics).to receive(:track).with(user, 'Login')

    described_class.new.perform(user.id)
  end
end
