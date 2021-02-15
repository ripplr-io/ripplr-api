require 'rails_helper'

RSpec.describe AutomatedPublishers::UpdateWorker, type: :worker do
  it 'schedules UpdateWorkers for each AutomatedPublisher' do
    automated_publisher = create(:automated_publisher)

    fetch_mock = double(urls: [
      'medium/p/post1',
      'medium/p/post2'
    ])

    allow(Feedjira::FetchUrlsService).to receive(:new).with(automated_publisher.feed_url).and_return(fetch_mock)

    described_class.new.perform(automated_publisher.id)

    expect(AutomatedPublishers::PublishWorker.jobs.size).to eq(2)
  end
end
