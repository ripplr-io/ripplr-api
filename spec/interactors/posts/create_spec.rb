require 'rails_helper'

RSpec.describe Posts::Create, type: :interactor do
  it 'creates the post' do
    post = build(:post)
    expect { described_class.call(resource: post) }
      .to change { Post.count }.by(1)

    expect(Posts::GenerateInboxItemsWorker.jobs.size).to eq(1)
    expect(Posts::BroadcastCreationWorker.jobs.size).to eq(1)
    expect(Posts::UpdateTrendingScoreWorker.jobs.size).to eq(1)
    expect(Trackers::TrackPostCreatedWorker.jobs.size).to eq(1)
    expect(Prizes::Onboarding::FirstPostWorker.jobs.size).to eq(1)
  end

  it 'creates the post with an image_url' do
    file = file_fixture('logo.png')
    allow_any_instance_of(URI::HTTPS).to receive(:open).and_return(file.open)

    post = build(:post, image: nil, image_url: 'https://ripplr.io/logo.png')

    expect { described_class.call(resource: post) }
      .to change { Post.count }.by(1)

    expect(Post.last.image.attached?).to be true
  end
end
