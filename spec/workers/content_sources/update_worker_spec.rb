require 'rails_helper'

RSpec.describe ContentSources::UpdateWorker, type: :worker do
  it 'schedules UpdateWorkers for each ContentSource' do
    content_source = create(:content_source)

    fetch_mock = double(urls: [
      'medium/p/post1',
      'medium/p/post2'
    ])

    allow(Feedjira::FetchUrlsService).to receive(:new).with(content_source.feed_url).and_return(fetch_mock)

    described_class.new.perform(content_source.id)

    expect(ContentSources::PublishWorker.jobs.size).to eq(2)
  end
end
