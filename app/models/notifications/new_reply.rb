module Notifications
  class NewReply < Notification
    attr_accessor :comment

    before_validation :set_data

    private

    def set_data
      return if @comment.nil?

      self.data = {
        type: type.split('::').last.underscore,
        id: @comment.id,
        post_id: @comment.post_id,
        author_id: @comment.author_id
      }
    end
  end
end
