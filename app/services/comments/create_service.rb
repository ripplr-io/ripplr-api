module Comments
  class CreateService < Resources::CreateService
    def initialize(attributes)
      super(Comment.new(attributes))
    end

    def save
      success = @resource.save
      if success
        generate_new_comment_notification
        generate_new_reply_notifications
      end
      success
    end

    private

    def generate_new_comment_notification
      return if @resource.comment.present?
      return if @resource.author == @resource.post.author

      Notifications::NewComment.create(user: @resource.post.author, comment: @resource)
    end

    def generate_new_reply_notifications
      return if @resource.comment.blank?

      # Users that replied to the comment
      comment_follower_ids = @resource.comment.comments.pluck(:author_id)

      # Comment author
      comment_follower_ids << @resource.comment.author_id

      # Remove author of the new reply
      comment_follower_ids.delete(@resource.author_id)

      # Remove duplicates
      comment_follower_ids.uniq!

      comment_follower_ids.each do |user_id|
        Notifications::NewReply.create(user_id: user_id, comment: @resource)
      end
    end
  end
end
