FactoryBot.define do
  factory :subscription do
    user
    settings { '{}' }

    inboxes do
      [
        user.inboxes.first || build(:inbox, user: user)
      ]
    end

    for_user

    trait :for_user do
      subscribable factory: :user
    end
  end
end
