require 'rails_helper'

RSpec.describe Mixpanel::TrackSignupWorker, type: :worker do
  it 'calls the mixpanel service' do
    user = create(:user)

    expect(Mixpanel::BaseService).to receive(:new).with(user).and_call_original
    expect_any_instance_of(Mixpanel::BaseService).to receive(:sync_user)
    expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('Signup')

    described_class.new.perform(user.id)
  end
end
