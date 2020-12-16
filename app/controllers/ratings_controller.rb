class RatingsController < ApplicationController
  include JsonApi::Crudable

  load_resource :post
  load_and_authorize_resource through: :post

  def create
    @rating = Ratings::CreateService.new(@rating)
    create_resource(@rating)
  end

  def rating_params
    { points: params[:rate] }
  end
end
