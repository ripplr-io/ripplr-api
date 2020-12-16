class NotificationsController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  serializer include: [:user, :author]

  def index
    @notifications = @notifications.order(created_at: :desc)
    read_resource(@notifications)
  end

  def read
    @notification.touch(:read_at)
  end

  def read_all
    @notifications.touch_all(:read_at)
  end
end
