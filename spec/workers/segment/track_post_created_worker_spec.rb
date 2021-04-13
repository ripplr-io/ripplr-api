require 'rails_helper'

RSpec.describe Segment::TrackPostCreatedWorker, type: :worker do
  it 'calls the service' do
    post = create(:post)

    expect_any_instance_of(Segment::TrackService).to receive(:call).with(post.author, 'Post Created')

    described_class.new.perform(post.id)
  end
end
