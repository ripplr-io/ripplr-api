class TicketsController < ApplicationController
  include Crudable

  before_action :authenticate_user!

  def create
    @ticket = current_user.tickets.new(ticket_params)
    create_resource(@ticket)
  end

  private

  def ticket_params
    screenshots = (params[:screenshots] || {}).values
    params.permit(:title, :body).merge!(screenshots: screenshots)
  end
end
