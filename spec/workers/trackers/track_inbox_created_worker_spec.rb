require 'rails_helper'

RSpec.describe Trackers::TrackInboxCreatedWorker, type: :worker do
  it 'calls the service' do
    inbox = create(:inbox)

    expect(Analytics).to receive(:track).with(inbox.user, 'Inbox Created')

    described_class.new.perform(inbox.id)
  end
end
