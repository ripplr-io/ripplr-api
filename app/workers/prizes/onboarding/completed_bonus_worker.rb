module Prizes
  module Onboarding
    class CompletedBonusWorker < ApplicationWorker
      TEMPLATE = Prize::ONBOARDING_PRIZES[:completed]

      def perform(user_id)
        user = User.find_by(id: user_id)
        return if user.blank?

        names = onboarding_prize_names
        return if user.prizes.where(name: names).size < names.size

        prize = Prize.new({ user: user }.merge(TEMPLATE))
        return if user.prizes.where(name: prize.name).present?

        Prizes::Create.call(resource: prize)
        Account::BroadcastChangesWorker.perform_async(user.id)
      end

      private

      def onboarding_prize_names
        prizes = Prize::ONBOARDING_PRIZES.reject do |key, _|
          key == :completed
        end

        prizes.values.pluck(:name)
      end
    end
  end
end
