require 'rails_helper'

RSpec.describe Segment::TrackInboxCreatedWorker, type: :worker do
  it 'calls the service' do
    inbox = create(:inbox)

    expect_any_instance_of(Segment::TrackService).to receive(:call).with(inbox.user, 'Inbox Created')

    described_class.new.perform(inbox.id)
  end
end
