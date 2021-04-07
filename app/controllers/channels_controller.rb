class ChannelsController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource
  serializer include: [:channelable]

  def index
    read_resource(@channels)
  end

  def create
    @channel.channelable = build_channelable
    create_resource(@channel, interactor: Channels::Create)
  end

  def update
    @channel.assign_attributes(channel_params)
    @channel.channelable.assign_attributes(channelable_params)
    update_resource(@channel)
  end

  def destroy
    destroy_resource(@channel)
  end

  private

  def channel_params
    params.permit(:name).merge(
      settings: JSON.parse(params[:settings] || '{}')
    )
  end

  def build_channelable
    return Channel::Email.new if params[:channelable_type] == 'channel_email'

    Channel::Device.new(device_params)
  end

  def channelable_params
    device_params if @channel.channel_device?

    {}
  end

  def device_params
    return {} if params[:channelable].blank?

    params.require(:channelable).permit(:onesignal_id)
  end
end
