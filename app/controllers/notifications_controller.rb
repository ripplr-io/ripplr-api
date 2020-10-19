class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    notifications = current_user.notifications.order(created_at: :desc)
    render json: notifications, include: :user
  end

  def read
    current_user.notifications.find(params[:id])&.touch(:read_at)
  end

  def read_all
    current_user.notifications.update_all(read_at: Time.current)
  end
end
