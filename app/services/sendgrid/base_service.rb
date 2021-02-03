module Sendgrid
  class BaseService
    def initialize
      @sg = SendGrid::API.new(api_key: Rails.application.credentials[:sendgrid_token])
    end
  end
end
