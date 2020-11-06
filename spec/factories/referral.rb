FactoryBot.define do
  factory :referral do
    inviter factory: :user
    invitee { nil }

    name { Faker::Name.name }
    email { Faker::Internet.email }
    accepted_at { nil }

    trait :with_invitee do
      invitee factory: :user
    end
  end
end
