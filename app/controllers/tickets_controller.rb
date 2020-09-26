class TicketsController < ApplicationController
  def create
    current_user.tickets.create!(ticket_params)
  end

  private

  def ticket_params
    screenshots = (params[:screenshots] || {}).values
    params.require(:ticket).permit(:title, :body).merge!(screenshots: screenshots)
  end
end
