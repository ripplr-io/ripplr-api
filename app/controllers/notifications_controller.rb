class NotificationsController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  serializer include: [:profile, :author]

  def index
    @notifications = @notifications
      .order(last_activity_at: :desc)
      .includes(:notifiable, user: :profile)

    read_resource(@notifications)
  end

  def read
    mark_as_read(@notification)
  end

  def read_all
    @notifications.each do |notification|
      mark_as_read(notification)
    end
  end

  private

  def mark_as_read(notification)
    notification.update(read_at: Time.current)
  end
end
