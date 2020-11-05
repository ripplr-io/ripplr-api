module AuthenticationHelpers
  def token_for(user)
    user.access_tokens.first_or_create.token
  end

  def auth_headers_for(user)
    {
      Authorization: "Bearer #{token_for(user)}"
    }
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers
end
