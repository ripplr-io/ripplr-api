module Account
  class OnboardController < ApplicationController
    include Crudable

    authorize_resource class: :account

    def update
      current_user.assign_attributes(onboarded_at: Time.current)
      update_resource(current_user)
    end
  end
end
