class ApplicationController < ActionController::API
  include JsonApi::Renderable

  respond_to :json

  before_action :authenticate_user!
  check_authorization

  rescue_from ActiveRecord::RecordNotFound, CanCan::AccessDenied do
    head :not_found
  end

  private

  def current_user
    @_current_user ||= User.find_by(id: doorkeeper_token&.resource_owner_id)
  end

  def authenticate_user!
    doorkeeper_authorize! if current_user.present?
  end
end
