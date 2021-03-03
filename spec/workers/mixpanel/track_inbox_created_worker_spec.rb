require 'rails_helper'

RSpec.describe Mixpanel::TrackInboxCreatedWorker, type: :worker do
  it 'calls the mixpanel service' do
    inbox = create(:inbox)

    expect(Mixpanel::BaseService).to receive(:new).with(inbox.user).and_call_original
    expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('Inbox Created')

    described_class.new.perform(inbox.id)
  end
end
