module Doorkeeper
  class ExtendedTokensController < Doorkeeper::TokensController
    def create
      if authorize_response.status == :ok
        user = User.find_by(id: authorize_response&.token&.resource_owner_id)
        Mixpanel::TrackLoginWorker.perform_async(user.id) if user.present?
      end

      super
    end
  end
end
