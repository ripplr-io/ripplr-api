require 'rails_helper'

RSpec.describe Segment::TrackCommentCreatedWorker, type: :worker do
  it 'calls the service' do
    comment = create(:comment)

    expect_any_instance_of(Segment::TrackService).to receive(:call).with(comment.author, 'Comment Created')

    described_class.new.perform(comment.id)
  end
end
