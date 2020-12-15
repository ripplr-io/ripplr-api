module Account
  class OnboardController < ApplicationController
    include Crudable

    authorize_resource class: :account

    def update
      params[:status] == 'finished' ? finish_onboarding : start_onboarding
      update_resource(current_user, serializer: AccountSerializer, included_associations: [:level])
    end

    private

    def start_onboarding
      current_user.assign_attributes(onboarding_started_at: Time.current)
    end

    def finish_onboarding
      current_user.assign_attributes(onboarding_finished_at: Time.current)
      Prizes::Onboarding::CompletedBonusWorker.perform_async(current_user.id)
    end
  end
end
