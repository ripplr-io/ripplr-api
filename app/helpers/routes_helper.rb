module RoutesHelper
  def web_app_route
    Rails.application.credentials[:web_app_route]
  end

  def password_reset_route(token)
    "#{web_app_route}/auth/password-reset?token=#{token}"
  end
end
