module ContentSources
  class PublishWorker < ApplicationWorker
    def perform(user_id, topic_id, url)
      user = User.find_by(id: user_id)
      topic = Topic.find_by(id: topic_id)
      return if user.blank? || topic.blank?

      data = Posts::PreviewService.new(url).data
      return if user.posts.find_by(url: data[:url]).present?

      post = user.posts.build(
        url: data[:url],
        title: data[:title],
        body: data[:body],
        topic: topic
      )

      interactor = Posts::Create.call(resource: post, image_url: data[:image] || Post::DEFAULT_IMAGE)
      log_errors(interactor) unless interactor.success?
    end

    private

    def log_errors(interactor)
      error_messages = interactor.resource.errors.full_messages
      Rails.logger.info "ContentSources::PublishWorker failed: #{error_messages}"
    end
  end
end
