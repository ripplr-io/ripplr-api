module AutomatedPublishers
  class UpdateWorker < ApplicationWorker
    def perform(automated_publisher_id)
      automated_publisher = AutomatedPublisher.find_by(id: automated_publisher_id)
      return if automated_publisher.blank?

      feedjira = Feedjira::FetchUrlsService.new(automated_publisher.feed_url)
      feedjira.urls.reverse_each do |url|
        AutomatedPublishers::PublishWorker.perform_async(automated_publisher.user.id, automated_publisher.topic.id, url)
      end
    end
  end
end
