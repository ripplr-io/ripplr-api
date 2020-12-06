module Mixpanel
  class TrackPostViewWorker < BaseWorker
    EVENT_NAME = 'Post View'.freeze

    def perform(user_id, post_id)
      post = Post.find_by(id: post_id)
      user = User.find_by(id: user_id)
      return if post.blank? || user.blank?

      Mixpanel::BaseService.new(user.id).track(EVENT_NAME, {
        post_id: post.id
      })
    end
  end
end
