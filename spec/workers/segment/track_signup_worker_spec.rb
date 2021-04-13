require 'rails_helper'

RSpec.describe Segment::TrackSignupWorker, type: :worker do
  it 'calls the service' do
    user = create(:user)

    expect_any_instance_of(Segment::IdentifyService).to receive(:call).with(user)
    expect_any_instance_of(Segment::TrackService).to receive(:call).with(user, 'Signup')

    described_class.new.perform(user.id)
  end
end
