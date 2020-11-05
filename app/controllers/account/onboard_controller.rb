module Account
  class OnboardController < ApplicationController
    include Crudable

    before_action :doorkeeper_authorize!

    def update
      current_user.assign_attributes(onboarded_at: Time.current)
      update_resource(current_user)
    end
  end
end
