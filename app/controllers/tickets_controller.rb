class TicketsController < ApplicationController
  def create
    # TODO: Replace with ticket params
    current_user.tickets.create!(title: params[:title], body: params[:body])
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :body)
  end
end
