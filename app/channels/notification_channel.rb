class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from "notifications_#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
