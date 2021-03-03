require 'rails_helper'

RSpec.describe Mixpanel::TrackCommentCreatedWorker, type: :worker do
  it 'calls the mixpanel service' do
    comment = create(:comment)

    expect(Mixpanel::BaseService).to receive(:new).with(comment.author).and_call_original
    expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('Comment Created')

    described_class.new.perform(comment.id)
  end
end
