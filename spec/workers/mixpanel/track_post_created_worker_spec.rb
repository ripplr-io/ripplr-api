require 'rails_helper'

RSpec.describe Mixpanel::TrackPostCreatedWorker, type: :worker do
  it 'calls the mixpanel service' do
    post = create(:post)

    expect(Mixpanel::BaseService).to receive(:new).with(post.author).and_call_original
    expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('Post Created')

    described_class.new.perform(post.id)
  end
end
