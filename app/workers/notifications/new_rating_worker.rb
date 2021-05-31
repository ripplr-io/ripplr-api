module Notifications
  class NewRatingWorker < ApplicationWorker
    def perform(rating_id)
      rating = Rating.find_by(id: rating_id)
      return if rating.blank?

      @ratable = rating.ratable
      @user = @ratable.author.user

      notification = find_or_build_notification
      notification.notification_new_rating.ratable = @ratable
      notification.last_activity_at = Time.current
      notification.read_at = nil
      notification.save
    end

    private

    def find_or_build_notification
      find_notification || build_notification
    end

    def find_notification
      Notification::NewRating.find_by(ratable: @ratable)&.notification
    end

    def build_notification
      @user.notifications.new(notifiable: Notification::NewRating.new)
    end
  end
end
