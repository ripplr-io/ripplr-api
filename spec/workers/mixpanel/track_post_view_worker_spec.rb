require 'rails_helper'

RSpec.describe Mixpanel::TrackPostViewWorker, type: :worker do
  it 'calls the mixpanel service' do
    post = create(:post)
    user = create(:user)

    expect(Mixpanel::BaseService).to receive(:new).with(user.id).and_call_original
    expect_any_instance_of(Mixpanel::BaseService).to receive(:track).with('Post View', { post_id: post.id })

    described_class.new.perform(user.id, post.id)
  end
end
