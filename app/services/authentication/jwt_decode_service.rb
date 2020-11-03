module Authentication
  class JwtDecodeService
    def initialize(token, validate_expiration: true)
      @token_data = decode_token(token, validate_expiration)
    end

    def user
      return nil if @token_data.blank?

      User.find_by(id: @token_data['sub'], jti: @token_data['jti'])
    end

    private

    def decode_token(token, validate_expiration)
      JWT.decode(token, Rails.application.credentials.secret_key_base, true, {
        algorithm: 'HS256',
        verify_expiration: validate_expiration # FIXME: Add max time
      })[0]
    rescue JWT::DecodeError
      nil
    end
  end
end
