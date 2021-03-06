module ContentSources
  class UpdateWorker < ApplicationWorker
    MAX_RESULTS = 3

    sidekiq_options retry: false

    def perform(content_source_id, fetch_all_entries: false)
      @content_source = ContentSource.find_by(id: content_source_id)
      return if @content_source.blank?

      feedjira = Feedjira::FetchUrlsService.new(@content_source.feed_url)
      entries = fetch_all_entries ? feedjira.data : feedjira.data.first(MAX_RESULTS)

      entries.reverse_each do |data|
        next if url_published?(data[:url])

        ContentSources::PublishWorker.perform_async(@content_source.id, data[:url], data.except(:url))
      end
    end

    private

    def url_published?(url)
      @content_source.user.profile.posts.where(url: url).any?
    end
  end
end
