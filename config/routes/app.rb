direct :app do
  Rails.application.credentials[:web_app_url]
end

direct :app_post do |post|
  "#{app_url}/p/#{post.id}"
end

direct :app_topic do |topic|
  "#{app_url}/t/#{topic.slug}"
end

direct :app_inbox do |inbox|
  "#{app_url}/inbox/#{inbox.id}"
end

direct :app_profile do |user|
  "#{app_url}/u/#{user.slug}"
end

direct :app_password_reset do |token|
  "#{app_url}/auth/password-reset?reset_password_token=#{token}"
end

direct :app_sign_up do |referral_id = nil|
  route = "#{app_url}/auth/register"
  route += "?referral_id=#{referral_id}" if referral_id.present?
  route
end

direct :app_customer_portal_return do
  "#{app_url}/account/billing"
end

direct :app_checkout_session_success do
  "#{app_url}/account/billing?checkout_session_status=success"
end

direct :app_checkout_session_cancel do
  "#{app_url}/account/billing?checkout_session_status=cancel"
end
