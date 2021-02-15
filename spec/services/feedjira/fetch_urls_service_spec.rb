require 'rails_helper'

RSpec.describe Feedjira::FetchUrlsService, type: :service do
  context '#youtube' do
    it 'extracts entries' do
      allow(HTTParty).to receive(:get) do
        double(body: File.open('spec/fixtures/feeds/youtube.xml').read)
      end

      urls = described_class.new('youtube.com/feed.xml').urls

      expect(urls).to include('https://www.youtube.com/watch?v=9zkFfBVgVtI')
      expect(urls).to include('https://www.youtube.com/watch?v=dhAmMXCBIcg')
    end
  end

  context '#medium' do
    it 'extracts entries' do
      allow(HTTParty).to receive(:get) do
        double(body: File.open('spec/fixtures/feeds/medium.xml').read)
      end

      urls = described_class.new('youtube.com/feed.xml').urls

      expect(urls).to include('https://medium.com/@ggraca/how-to-use-digitaloceans-container-registry-for-continuous-deployment-7e1bc3d19e0a?source=rss-8e93697e29f3------2')
      expect(urls).to include('https://medium.com/@ggraca/ripplr-development-2-a8fd62355e15?source=rss-8e93697e29f3------2')
    end
  end
end
