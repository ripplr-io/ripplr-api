module Account
  class MarketingController < ApplicationController
    include JsonApi::Crudable

    authorize_resource class: :account

    serializer class: AccountSerializer, include: [:level]

    def update
      current_user.assign_attributes(marketing_params)
      update_resource(current_user, interactor: Accounts::UpdateMarketing)
    end

    def marketing_params
      params.permit(:subscribed_to_marketing)
    end
  end
end
