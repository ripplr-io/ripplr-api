class RatingsController < ApplicationController
  include JsonApi::Crudable

  load_resource :post
  load_and_authorize_resource through: :post

  def create
    create_resource(@rating, interactor: Ratings::Create)
  end

  def rating_params
    { points: params[:rate] }
  end
end
