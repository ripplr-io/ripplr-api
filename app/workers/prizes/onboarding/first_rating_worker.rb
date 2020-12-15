module Prizes
  module Onboarding
    class FirstRatingWorker < ApplicationWorker
      TEMPLATE = Prize::ONBOARDING_PRIZES[:rating]

      def perform(user_id)
        user = User.find_by(id: user_id)
        return if user.blank?
        return if user.ratings.empty?

        prize = Prize.new({ user: user }.merge(TEMPLATE))
        return if user.prizes.where(name: prize.name).present?

        Prizes::CreateService.new(prize).save
        Account::BroadcastChangesWorker.perform_async(user.id)
      end
    end
  end
end
