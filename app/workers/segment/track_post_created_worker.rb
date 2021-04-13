module Segment
  class TrackPostCreatedWorker < BaseWorker
    EVENT_NAME = 'Post Created'.freeze

    def perform(post_id)
      post = Post.find_by(id: post_id)
      return if post.blank?

      Segment::TrackService.new.call(post.author, EVENT_NAME)
    end
  end
end
