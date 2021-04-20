require 'rails_helper'

RSpec.describe ContentSources::PublishWorker, type: :worker do
  context 'with complete feed_data' do
    it 'creates a post' do
      content_source = create(:content_source)
      url = 'http://youtube.com/post/id'
      feed_data = {
        title: 'Title',
        body: 'Body',
        image: 'https://youtube.com/post/id.png'
      }

      # Preview
      expect(LinkPreview).not_to receive(:fetch)

      # Mock Image Download
      file = file_fixture('logo.png')
      allow_any_instance_of(URI::HTTPS).to receive(:open).and_return(file.open)

      expect { described_class.new.perform(content_source.id, url, feed_data) }
        .to change { Post.count }.by(1)

      expect(Post.last.url).to eq(url)
      expect(Post.last.title).to eq('Title')
      expect(Post.last.body).to eq('Body')
      expect(Post.last.image).not_to eq(nil)
    end
  end

  context 'with missing feed_data' do
    it 'uses meta_data for the missing fields' do
      content_source = create(:content_source)
      url = 'http://youtube.com/post/id'
      feed_data = {
        title: 'Title'
      }

      # Mock Preview Download
      preview = {
        url: url,
        title: 'New Title',
        body: 'New Body',
        image: 'https://youtube.com/post/id.png'
      }
      allow(LinkPreview).to receive(:fetch).with(url).and_return(preview)

      # Mock Image Download
      file = file_fixture('logo.png')
      allow_any_instance_of(URI::HTTPS).to receive(:open).and_return(file.open)

      expect { described_class.new.perform(content_source.id, url, feed_data) }
        .to change { Post.count }.by(1)

      expect(Post.last.url).to eq(url)
      expect(Post.last.title).to eq('Title')
      expect(Post.last.body).to eq('New Body')
      expect(Post.last.image).not_to eq(nil)
    end
  end

  context 'existing post' do
    it 'exits without creating the post' do
      content_source = create(:content_source)
      url = 'http://youtube.com/post/id'
      create(:post, author: content_source.user, url: url)

      expect { described_class.new.perform(content_source.id, url) }
        .to change { Post.count }.by(0)
    end
  end
end
