module Accounts
  class CreateService < Resources::CreateService
    def initialize(attributes, referral_id: nil)
      super(User.new(attributes))
      @referral_id = referral_id
    end

    def save
      @resource.level = Level.first
      @resource.referral = Referral.find_by(id: @referral_id)

      ActiveRecord::Base.transaction do
        @resource.save!
        @resource.bookmark_folders.create!(name: 'Root')
      end

      if @resource.referral.present?
        Notifications::ReferralAccepted.create(user: @resource.referral.inviter, referral: @resource.referral)
      end

      true
    rescue ActiveRecord::RecordInvalid
      false
    end
  end
end
