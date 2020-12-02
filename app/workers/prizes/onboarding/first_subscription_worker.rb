module Prizes
  module Onboarding
    class FirstSubscriptionWorker < ApplicationWorker
      TEMPLATE = Prize::ONBOARDING_PRIZES[:subscription]

      def perform(user_id)
        user = User.find_by(id: user_id)
        return if user.blank?
        return if user.subscriptions.empty?

        prize = Prize.new({ user: user }.merge(TEMPLATE))
        return if user.prizes.where(name: prize.name).present?

        Prizes::CreateService.new(prize).save
      end
    end
  end
end
