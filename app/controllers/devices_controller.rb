class DevicesController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  def index
    read_resource(@devices)
  end

  def create
    @device = Devices::CreateService.new(@device)
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
