require 'rails_helper'

RSpec.describe Posts::PushNotifications::GenerateForDeviceWorker, type: :worker do
  it 'creates a push_notification' do
    post = create(:post)
    subscription = create(:subscription)
    device = create(:device)

    # Default will be all topics / all slots
    expect { described_class.new.perform(post.id, subscription.id, device.id) }
      .to change { PushNotification.count }.by(1)
  end

  it 'is idempotent' do
    post = create(:post)
    subscription = create(:subscription)
    device = create(:device)

    expect { described_class.new.perform(post.id, subscription.id, device.id) }
      .to change { PushNotification.count }.by(1)

    expect { described_class.new.perform(post.id, subscription.id, device.id) }
      .to change { PushNotification.count }.by(0)
  end
end
