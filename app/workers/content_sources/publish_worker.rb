module ContentSources
  class PublishWorker < ApplicationWorker
    MAX_TITLE_LENGTH = 160
    MAX_BODY_LENGTH = 256

    def perform(content_source_id, url, feed_data = {})
      content_source = ContentSource.find_by(id: content_source_id)
      return if content_source.blank? || url.blank?
      return if content_source.user.posts.where(url: url).any?

      @url = url
      feed_data.symbolize_keys!
      image_url = feed_data[:image] || meta_data[:image] || Post::DEFAULT_IMAGE

      post = content_source.user.posts.build({
        topic: content_source.community.topics.first,
        communities: [content_source.community],
        url: @url,
        title: (feed_data[:title] || meta_data[:title] || '').truncate(MAX_TITLE_LENGTH),
        body: (feed_data[:body] || meta_data[:body] || '').truncate(MAX_BODY_LENGTH),
        image_url: image_url
      })

      interactor = Posts::Create.call(resource: post)
      log_resource_interaction(interactor)
    end

    private

    def meta_data
      @_meta_data ||= LinkPreview.fetch(@url)
    end
  end
end
