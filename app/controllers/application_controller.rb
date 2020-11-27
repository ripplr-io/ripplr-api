class ApplicationController < ActionController::API
  respond_to :json

  check_authorization unless: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, CanCan::AccessDenied do
    head :not_found
  end

  private

  def current_user
    @_current_user ||= User.find_by(id: doorkeeper_token&.resource_owner_id)
  end
end
