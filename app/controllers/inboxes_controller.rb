class InboxesController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  def index
    read_resource(@inboxes)
  end

  def show
    read_resource(@inbox)
  end

  def create
    create_resource(@inbox)
  end

  def update
    @inbox.assign_attributes(inbox_params)
    update_resource(@inbox)
  end

  def destroy
    destroy_resource(@inbox)
  end

  private

  # NOTE: for new inbox_channels, ids need to be sent with null to avoid multiple entries from merging
  def inbox_params
    (params[:inbox_channels_attributes] || []).each do |inbox_channel|
      inbox_channel[:user_id] = current_user.id
    end

    params.permit(:name, :description, :settings, inbox_channels_attributes: [:id, :channel_id, :user_id, :_destroy])
  end
end
