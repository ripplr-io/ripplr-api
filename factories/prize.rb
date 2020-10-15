FactoryBot.define do
  factory :prize do
    for_referral
    user

    points { Faker::Number.within(range: 1..128) }
    name { Faker::Lorem.word }
    given_at { nil }

    trait :for_referral do
      prizable factory: :referral
    end
  end
end
