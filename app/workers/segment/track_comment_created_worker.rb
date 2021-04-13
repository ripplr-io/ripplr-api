module Segment
  class TrackCommentCreatedWorker < BaseWorker
    EVENT_NAME = 'Comment Created'.freeze

    def perform(comment_id)
      comment = Comment.find_by(id: comment_id)
      return if comment.blank?

      Segment::TrackService.new.call(comment.author, EVENT_NAME)
    end
  end
end
