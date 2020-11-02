class TicketsController < ApplicationController
  include Crudable

  before_action :authenticate_user!

  def create
    @ticket = Tickets::CreateService.new(ticket_params.merge!(user: current_user))
    create_resource(@ticket)
  end

  private

  def ticket_params
    screenshots = (params[:screenshots] || {}).values
    params.permit(:title, :body).merge!(screenshots: screenshots)
  end
end
