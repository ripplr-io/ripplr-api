class NotificationsController < ApplicationController
  include Crudable

  load_and_authorize_resource

  def index
    @notifications = @notifications.order(created_at: :desc)
    read_resource(@notifications, included_associations: [:user, :author])
  end

  def read
    @notification.touch(:read_at)
  end

  def read_all
    @notifications.touch_all(:read_at)
  end
end
