require 'rails_helper'

RSpec.describe Posts::CreateService, type: :service do
  it 'creates the post' do
    post_params = {
      author: create(:user),
      topic: create(:topic),
      title: 'Title',
      body: 'Body',
      image: 'Image',
      url: 'Url'
    }

    expect { described_class.new(post_params).save }
      .to change { Post.count }.by(1)

    expect(Posts::PushNotifications::GenerateWorker).to have_enqueued_sidekiq_job(anything)
    expect(Posts::BroadcastCreationWorker).to have_enqueued_sidekiq_job(anything)
  end
end
