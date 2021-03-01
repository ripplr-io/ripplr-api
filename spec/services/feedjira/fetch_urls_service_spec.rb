require 'rails_helper'

RSpec.describe Feedjira::FetchUrlsService, type: :service do
  context '#youtube' do
    it 'extracts entries' do
      allow(HTTParty).to receive(:get) do
        double(body: File.open('spec/fixtures/feeds/youtube.xml').read)
      end

      data = described_class.new('youtube.com/feed.xml').data

      expect(data[0][:url]).to eq('https://www.youtube.com/watch?v=9zkFfBVgVtI')
      expect(data[1][:url]).to eq('https://www.youtube.com/watch?v=dhAmMXCBIcg')
      expect(data[1][:title]).to eq('Galaxy S21 Review: Would You Notice?')
      expect(data[1][:body]).to eq('Description')
      expect(data[1][:image]).to eq('https://i1.ytimg.com/vi/dhAmMXCBIcg/hqdefault.jpg')
    end
  end

  context '#medium' do
    it 'extracts entries' do
      allow(HTTParty).to receive(:get) do
        double(body: File.open('spec/fixtures/feeds/medium.xml').read)
      end

      data = described_class.new('youtube.com/feed.xml').data

      expect(data[0][:url]).to eq('https://medium.com/@ggraca/how-to-use-digitaloceans-container-registry-for-continuous-deployment-7e1bc3d19e0a?source=rss-8e93697e29f3------2')
      expect(data[1][:url]).to eq('https://medium.com/@ggraca/ripplr-development-2-a8fd62355e15?source=rss-8e93697e29f3------2')
      expect(data[1][:title]).to eq('Ripplr Development #2')
      expect(data[1][:body]).to eq('Our beta program started 2 weeks ago')
      expect(data[1][:image]).to eq(nil)
    end
  end
end
