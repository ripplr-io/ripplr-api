require 'rails_helper'

RSpec.describe Posts::Create, type: :interactor do
  it 'creates the post' do
    post = build(:post)
    expect { described_class.call(resource: post) }
      .to change { Post.count }.by(1)

    expect(Posts::GenerateInboxItemsWorker.jobs.size).to eq(1)
    expect(Posts::PushNotifications::GenerateWorker.jobs.size).to eq(1)
    expect(Posts::BroadcastCreationWorker.jobs.size).to eq(1)
    expect(Mixpanel::TrackPostCreatedWorker.jobs.size).to eq(1)
    expect(Prizes::Onboarding::FirstPostWorker.jobs.size).to eq(1)
  end

  it 'creates the post with an image_url' do
    file = File.open('spec/fixtures/logo.png')
    allow_any_instance_of(URI::HTTPS).to receive(:open).and_return(file)
    post = build(:post)

    expect { described_class.call(resource: post, image_url: 'https://ripplr.io/logo.png') }
      .to change { Post.count }.by(1)

    expect(Post.last.image.attached?).to be true
  end

  context 'level limit reached' do
    it 'does not create the post' do
      level = create(:level, posts: 2)
      user = create(:user, level: level)
      create_list(:post, 2, author: user)

      post = build(:post, author: user)

      expect { described_class.call(resource: post) }
        .to change { Post.count }.by(0)
    end
  end
end
