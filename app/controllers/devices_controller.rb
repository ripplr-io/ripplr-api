class DevicesController < ApplicationController
  include Crudable

  load_and_authorize_resource

  def index
    read_resource(@devices)
  end

  # TODO: Use cancancan
  def create
    @device = Devices::CreateService.new(device_params.merge(user: current_user))
    create_resource(@device)
  end

  def update
    @device.assign_attributes(device_params)
    update_resource(@device)
  end

  def destroy
    destroy_resource(@device)
  end

  private

  def device_params
    params.permit(:name, :onesignal_id).merge(
      settings: JSON.parse(params[:settings] || '{}'),
      device_type: params[:type]
    )
  end
end
