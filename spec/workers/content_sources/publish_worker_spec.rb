require 'rails_helper'

RSpec.describe ContentSources::PublishWorker, type: :worker do
  context 'valid preview' do
    it 'creates a post' do
      user = create(:user)
      topic = create(:topic)
      url = 'youtube.com/post/id'

      # Mock Preview Download
      preview_mock = double(data: {
        url: url,
        title: 'Title',
        body: 'Body',
        image: 'https://youtube.com/post/id.png'
      })
      allow(Posts::PreviewService).to receive(:new).with(url).and_return(preview_mock)

      # Mock Image Download
      file = File.open('spec/fixtures/logo.png')
      allow_any_instance_of(URI::HTTPS).to receive(:open).and_return(file)

      expect { described_class.new.perform(user.id, topic.id, url) }
        .to change { Post.count }.by(1)

      expect(Post.last.url).to eq(url)
      expect(Post.last.title).to eq('Title')
      expect(Post.last.body).to eq('Body')
      expect(Post.last.image).not_to eq(nil)
    end
  end

  context 'invalid preview' do
    it 'logs an error' do
      user = create(:user)
      topic = create(:topic)
      url = 'youtube.com/post/id'

      # Mock Preview Download
      preview_mock = double(data: {
        url: url
      })
      allow(Posts::PreviewService).to receive(:new).with(url).and_return(preview_mock)

      # Mock Image Download
      file = File.open('spec/fixtures/logo.png')
      allow_any_instance_of(URI::HTTPS).to receive(:open).and_return(file)

      expect(Rails.logger).to receive(:info)
      expect { described_class.new.perform(user.id, topic.id, url) }
        .to change { Post.count }.by(0)
    end
  end

  context 'existing post' do
    it 'exits without creating the post' do
      user = create(:user)
      topic = create(:topic)
      url = 'youtube.com/post/id'
      create(:post, author: user, url: url)

      # Mock Preview Download
      preview_mock = double(data: {
        url: url,
        title: 'Title',
        body: 'Body',
        image: 'https://youtube.com/post/id.png'
      })
      allow(Posts::PreviewService).to receive(:new).with(url).and_return(preview_mock)

      expect { described_class.new.perform(user.id, topic.id, url) }
        .to change { Post.count }.by(0)
    end
  end
end
