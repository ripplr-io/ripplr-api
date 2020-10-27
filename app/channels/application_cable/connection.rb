module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      token = request.params['token']
      return reject_unauthorized_connection if token.nil?

      jwt = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
      User.find_by(id: jwt['sub']) || reject_unauthorized_connection
    end
  end
end
