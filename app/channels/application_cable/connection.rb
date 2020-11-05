module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      access_token = Doorkeeper::AccessToken.by_token(request.params[:token])
      user = User.find_by(id: access_token&.resource_owner_id)
      user || reject_unauthorized_connection
    end
  end
end
