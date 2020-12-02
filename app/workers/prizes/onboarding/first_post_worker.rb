module Prizes
  module Onboarding
    class FirstPostWorker < ApplicationWorker
      TEMPLATE = Prize::ONBOARDING_PRIZES[:post]

      def perform(user_id)
        user = User.find_by(id: user_id)
        return if user.blank?
        return if user.posts.empty?

        prize = Prize.new({ user: user }.merge(TEMPLATE))
        return if user.prizes.where(name: prize.name).present?

        Prizes::CreateService.new(prize).save
      end
    end
  end
end
