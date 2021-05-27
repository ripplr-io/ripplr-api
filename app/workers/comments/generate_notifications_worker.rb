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
      return if @comment.author == @comment.post.author

      Notification.create(
        user: @comment.post.author.user,
        notifiable: Notification::NewComment.new(comment: @comment)
      )
    end

    def generate_new_reply_notifications
      return if @comment.comment.blank?

      # Users that replied to the comment
      comment_follower_ids = @comment.comment.comments.pluck(:profile_id)

      # Comment author
      comment_follower_ids << @comment.comment.profile_id

      # Remove author of the new reply
      comment_follower_ids.delete(@comment.profile_id)

      # Remove duplicates
      comment_follower_ids.uniq!

      user_ids = Profile.where(id: comment_follower_ids).pluck(:profilable_id)
      user_ids.each do |user_id|
        Notification.create(
          user_id: user_id,
          notifiable: Notification::NewReply.new(comment: @comment)
        )
      end
    end
  end
end
