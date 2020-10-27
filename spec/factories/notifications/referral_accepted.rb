FactoryBot.define do
  factory :referral_accepted, class: Notifications::ReferralAccepted do
    user
    referral
  end
end
