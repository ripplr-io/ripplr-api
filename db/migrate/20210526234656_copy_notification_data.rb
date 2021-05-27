class CopyNotificationData < ActiveRecord::Migration[6.1]
  def up
    Notifications::NewComment.where(notifiable: nil).each do |notification|
      comment = Comment.find(notification.data['id'])
      notification.update!(notifiable: Notification::NewComment.new(comment: comment))
    end

    Notifications::NewReply.where(notifiable: nil).each do |notification|
      comment = Comment.find(notification.data['id'])
      notification.update!(notifiable: Notification::NewReply.new(comment: comment))
    end

    Notifications::NewLevel.where(notifiable: nil).each do |notification|
      level = Level.find(notification.data['level']['id'])
      notification.update!(notifiable: Notification::NewLevel.new(level: level))
    end

    Notifications::NewFollower.where(notifiable: nil).each do |notification|
      user = User.find(notification.data['author_id'])
      follow = Follow.find_by(followable: notification.user.profile, user: user)

      notification.update(notifiable: Notification::NewFollower.new(follow: follow))
    end

    Notifications::ReferralAccepted.where(notifiable: nil).each do |notification|
      referral = Referral.find(notification.data['id'])
      notification.update!(notifiable: Notification::AcceptedReferral.new(referral: referral))
    end
  end
end
