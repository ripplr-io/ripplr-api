class TicketsController < ApplicationController
  include Crudable

  load_and_authorize_resource

  def create
    @ticket = Tickets::CreateService.new(@ticket)
    create_resource(@ticket)
  end

  private

  def ticket_params
    screenshots = (params[:screenshots] || {}).values
    params.permit(:title, :body).merge(screenshots: screenshots)
  end
end
