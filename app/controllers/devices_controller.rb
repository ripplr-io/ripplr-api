class DevicesController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!
  before_action :find_device, only: [:update, :destroy]

  def index
    read_resource(current_user.devices)
  end

  def create
    @device = current_user.devices.new(device_params)
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

  def find_device
    @device = current_user.devices.find(params[:id])
  end

  def device_params
    params.permit(:name, :onesignal_id).merge!(
      settings: JSON.parse(params[:settings] || '{}'),
      device_type: params[:type]
    )
  end
end
