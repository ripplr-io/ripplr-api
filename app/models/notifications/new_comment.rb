module Notifications
  class NewComment < Notification
    attr_accessor :comment

    before_validation :set_data

    private

    def set_data
      return if @comment.nil?

      self.data = {
        type: type.split('::').last.underscore,
        id: @comment.id,
        post_id: @comment.post.id,
        author_id: @comment.profile.id
      }
    end
  end
end
