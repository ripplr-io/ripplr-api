class NotificationsController < ApplicationController
  def index
    notifications = current_user.notifications.order(created_at: :desc)
    data = ActiveModelSerializers::SerializableResource.new(notifications).as_json
    render json: { data: data }
  end

  def read
    current_user.notifications.find(params[:id])&.touch(:read_at)
  end

  def read_all
    current_user.notifications.update_all(read_at: Time.current)
  end
end
