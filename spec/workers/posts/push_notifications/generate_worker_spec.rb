require 'rails_helper'

RSpec.describe Posts::PushNotifications::GenerateWorker, type: :worker do
  it 'enqueues workers for each subscription/device pair' do
    post = create(:post)

    subscription_a = create(:subscription, subscribable: post.author)
    create(:device, user: subscription_a.user)

    subscription_b = create(:subscription, subscribable: post.author)
    create_list(:device, 2, user: subscription_b.user)

    described_class.new.perform(post.id)

    expect(Posts::PushNotifications::GenerateForDeviceWorker.jobs.size).to eq 3
  end
end
