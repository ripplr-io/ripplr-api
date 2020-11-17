# FIXME: Move this to a direct route https://guides.rubyonrails.org/routing.html#direct-routes
module RoutesHelper
  def web_app_route
    Rails.application.credentials[:web_app_url]
  end

  def password_reset_route(token)
    "#{web_app_route}/auth/password-reset?reset_password_token=#{token}"
  end

  def sign_up_route(referral_id = nil)
    route = "#{web_app_route}/auth/register"
    route += "?referral_id=#{referral_id}" if referral_id.present?
    route
  end
end
