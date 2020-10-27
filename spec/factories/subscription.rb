FactoryBot.define do
  factory :subscription do
    for_user
    user
    settings { Support::JsonResources.subscription_settings }

    trait :for_user do
      subscribable factory: :user
    end
  end
end
