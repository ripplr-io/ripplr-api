module Trackers
  class TrackCommentCreatedWorker < BaseWorker
    EVENT_NAME = 'Comment Created'.freeze

    def perform(comment_id)
      comment = Comment.find_by(id: comment_id)
      return if comment.blank?

      Analytics.track(comment.profile.user, EVENT_NAME)
    end
  end
end
