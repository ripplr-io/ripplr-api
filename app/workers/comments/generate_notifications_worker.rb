module Comments
  class GenerateNotificationsWorker < ApplicationWorker
    def perform(comment_id)
      @comment = Comment.find_by(id: comment_id)
      return if @comment.blank?

      generate_new_comment_notification
      generate_new_reply_notifications
    end

    private

    def generate_new_comment_notification
      return if @comment.comment.present?
      return if @comment.author == @comment.post.author.user

      Notifications::NewComment.create(user: @comment.post.author.user, comment: @comment)
    end

    def generate_new_reply_notifications
      return if @comment.comment.blank?

      # Users that replied to the comment
      comment_follower_ids = @comment.comment.comments.pluck(:author_id)

      # Comment author
      comment_follower_ids << @comment.comment.author_id

      # Remove author of the new reply
      comment_follower_ids.delete(@comment.author_id)

      # Remove duplicates
      comment_follower_ids.uniq!

      comment_follower_ids.each do |user_id|
        Notifications::NewReply.create(user_id: user_id, comment: @comment)
      end
    end
  end
end
