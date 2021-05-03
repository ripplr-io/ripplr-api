require 'rails_helper'

RSpec.describe Trackers::TrackPostCreatedWorker, type: :worker do
  it 'calls the service' do
    post = create(:post)

    expect(Analytics).to receive(:track).with(post.author.user, 'Post Created')

    described_class.new.perform(post.id)
  end
end
