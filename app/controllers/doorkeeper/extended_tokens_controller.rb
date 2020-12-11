module Doorkeeper
  class ExtendedTokensController < Doorkeeper::TokensController
    def create
      if authorize_response.status == :ok
        user = User.find_by(id: authorize_response&.token&.resource_owner_id)
        if user.present?
          Mixpanel::TrackLoginWorker.perform_async(user.id, request.ip, browser.name, browser.platform.name)
        end
      end

      super
    end
  end
end
