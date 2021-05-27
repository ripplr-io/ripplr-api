FactoryBot.define do
  factory :notification do
    for_new_level
    user

    trait :for_new_level do
      notifiable { association :notification_new_level, notification: instance }
    end

    trait :for_new_comment do
      notifiable { association :notification_new_comment, notification: instance }
    end

    trait :for_new_reply do
      notifiable { association :notification_new_reply, notification: instance }
    end

    trait :for_new_follower do
      notifiable { association :notification_new_follower, notification: instance }
    end

    trait :for_accepted_referral do
      notifiable { association :notification_accepted_referral, notification: instance }
    end
  end
end
