class NotificationsController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!

  def index
    notifications = current_user.notifications.order(created_at: :desc)
    read_resource(notifications, included_associations: [:user])
  end

  def read
    @notification = current_user.notifications.find(params[:id])
    @notification.touch(:read_at)
  end

  def read_all
    current_user.notifications.touch_all(:read_at)
  end
end
