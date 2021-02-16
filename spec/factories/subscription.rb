FactoryBot.define do
  factory :subscription do
    for_user
    user
    settings { '{}' }

    trait :for_user do
      subscribable factory: :user
    end
  end
end
