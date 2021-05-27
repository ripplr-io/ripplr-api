FactoryBot.define do
  factory :notification_accepted_referral, class: Notification::AcceptedReferral do
    referral
  end
end
