module Prizes
  module Onboarding
    class FirstFollowWorker < ApplicationWorker
      TEMPLATE = Prize::ONBOARDING_PRIZES[:follow]

      def perform(user_id)
        user = User.find_by(id: user_id)
        return if user.blank?
        return if user.follows.empty?

        prize = Prize.new({ user: user }.merge(TEMPLATE))
        return if user.prizes.where(name: prize.name).present?

        Prizes::Create.call(resource: prize)
        Account::BroadcastChangesWorker.perform_async(user.id)
      end
    end
  end
end
