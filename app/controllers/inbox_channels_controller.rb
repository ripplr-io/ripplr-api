class InboxChannelsController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  def create
    create_resource(@inbox_channel)
  end

  def update
    @inbox_channel.assign_attributes(inbox_channel_params)
    update_resource(@inbox_channel)
  end

  def destroy
    destroy_resource(@inbox_channel)
  end

  private

  def inbox_channel_params
    params.permit(:inbox_id, :channel_id).merge(
      settings: JSON.parse(params[:settings] || '{}')
    )
  end
end
