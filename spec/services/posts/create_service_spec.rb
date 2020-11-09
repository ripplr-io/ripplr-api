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

    expect(Posts::PushNotifications::GenerateWorker.jobs.size).to eq(1)
    expect(Posts::BroadcastCreationWorker.jobs.size).to eq(1)
  end

  context 'level limit reached' do
    it 'does not create the post' do
      level = create(:level, posts: 2)
      user = create(:user, level: level)
      create_list(:post, 2, author: user)

      post_params = {
        author: user,
        topic: create(:topic),
        title: 'Title',
        body: 'Body',
        image: 'Image',
        url: 'Url'
      }

      expect { described_class.new(post_params).save }
        .to change { Post.count }.by(0)
    end
  end
end
