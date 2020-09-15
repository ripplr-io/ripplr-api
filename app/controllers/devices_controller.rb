class DevicesController < ApplicationController
  def index
    data = ActiveModelSerializers::SerializableResource.new(current_user.devices).as_json
    render json: { data: data }
  end

  def create
    current_user.devices.create(device_params)
  end

  def update
    current_user.devices.find(params[:id]).update(device_params)
  end

  def destroy
    current_user.devices.find(params[:id]).destroy
  end

  private

  def device_params
    params.device(:follow).permit(:name, :settings, :onesignal_id, :type)
  end
end
