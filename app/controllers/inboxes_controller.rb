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

  def inbox_params
    params.permit(:name, :settings)
  end
end
