class TicketsController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  def create
    create_resource(@ticket, interactor: Tickets::Create)
  end

  private

  def ticket_params
    screenshots = (params[:screenshots] || {}).values
    params.permit(:title, :body).merge(screenshots: screenshots)
  end
end
