module Mixpanel
  class TrackPostCreatedWorker < BaseWorker
    EVENT_NAME = 'Post Created'.freeze

    def perform(post_id)
      post = Post.find_by(id: post_id)
      return if post.blank?

      Mixpanel::BaseService.new(post.author.id).track(EVENT_NAME)
    end
  end
end
