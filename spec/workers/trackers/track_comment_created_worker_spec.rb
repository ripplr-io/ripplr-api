require 'rails_helper'

RSpec.describe Trackers::TrackCommentCreatedWorker, type: :worker do
  it 'calls the service' do
    comment = create(:comment)

    expect(Analytics).to receive(:track).with(comment.author, 'Comment Created')

    described_class.new.perform(comment.id)
  end
end
