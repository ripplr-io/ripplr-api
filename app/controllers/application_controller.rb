class ApplicationController < ActionController::API
  respond_to :json
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def current_user
    @_current_user ||= User.find_by(id: doorkeeper_token&.resource_owner_id)
  end

  def not_found
    head :not_found
  end
end
