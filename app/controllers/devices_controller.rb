class DevicesController < ApplicationController
  def index
    data = ActiveModelSerializers::SerializableResource.new(current_user.devices).as_json
    render json: { data: data }
  end

  def create
    # TODO: Replace with strong params
    current_user.devices.create(
      name: params[:name],
      settings: JSON.parse(params[:settings]),
      onesignal_id: params[:onesignal_id],
      device_type: params[:type]
    )
  end

  def update
    # TODO: Replace with strong params
    current_user.devices.find(params[:id]).update(
      name: params[:name],
      settings: JSON.parse(params[:settings]),
      onesignal_id: params[:onesignal_id],
      device_type: params[:type]
    )
  end

  def destroy
    current_user.devices.find(params[:id]).destroy
  end

  private

  def device_params
    params.device(:device).permit(:name, :settings, :onesignal_id, :type)
  end
end
