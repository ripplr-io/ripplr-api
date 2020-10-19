class ApplicationController < ActionController::API
  respond_to :json
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found
    head :not_found
  end
end
