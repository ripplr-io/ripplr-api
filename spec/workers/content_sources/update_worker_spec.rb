require 'rails_helper'

RSpec.describe ContentSources::UpdateWorker, type: :worker do
  it 'schedules UpdateWorkers for each ContentSource' do
    content_source = create(:content_source)

    fetch_mock = double(data: [
      { url: 'http://medium.com/p/post1' },
      { url: 'http://medium.com/p/post2' }
    ])

    allow(Feedjira::FetchUrlsService).to receive(:new).with(content_source.feed_url).and_return(fetch_mock)

    described_class.new.perform(content_source.id)

    expect(ContentSources::PublishWorker.jobs.size).to eq(2)
  end

  it 'limits the number of results to 3' do
    content_source = create(:content_source)

    fetch_mock = double(data: [
      { url: 'http://medium.com/p/post1' },
      { url: 'http://medium.com/p/post2' },
      { url: 'http://medium.com/p/post3' },
      { url: 'http://medium.com/p/post4' }
    ])

    allow(Feedjira::FetchUrlsService).to receive(:new).with(content_source.feed_url).and_return(fetch_mock)

    described_class.new.perform(content_source.id)

    expect(ContentSources::PublishWorker.jobs.size).to eq(3)
  end

  it 'skips urls already created by that content_source' do
    content_source = create(:content_source)
    create(:post, url: 'http://medium.com/p/post2', author: content_source.user.profile)

    fetch_mock = double(data: [
      { url: 'http://medium.com/p/post1' },
      { url: 'http://medium.com/p/post2' }
    ])

    allow(Feedjira::FetchUrlsService).to receive(:new).with(content_source.feed_url).and_return(fetch_mock)

    described_class.new.perform(content_source.id)

    expect(ContentSources::PublishWorker.jobs.size).to eq(1)
  end
end
