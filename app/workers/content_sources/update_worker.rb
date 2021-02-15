module ContentSources
  class UpdateWorker < ApplicationWorker
    def perform(content_source_id)
      content_source = ContentSource.find_by(id: content_source_id)
      return if content_source.blank?

      feedjira = Feedjira::FetchUrlsService.new(content_source.feed_url)
      feedjira.urls.reverse_each do |url|
        ContentSources::PublishWorker.perform_async(content_source.user.id, content_source.topic.id, url)
      end
    end
  end
end
