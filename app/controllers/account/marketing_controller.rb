module Account
  class MarketingController < ApplicationController
    include JsonApi::Crudable

    authorize_resource class: :account

    serializer class: AccountSerializer, include: [:level]

    def update
      current_user.assign_attributes(marketing_params)
      service = Accounts::UpdateMarketingService.new(current_user)
      update_resource(service)
    end

    def marketing_params
      params.permit(:subscribed_to_marketing)
    end
  end
end
