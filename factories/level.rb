FactoryBot.define do
  factory :level do
    name { Faker::Lorem.word }
    from { Faker::Number.within(range: 1..255) }
    to { Faker::Number.within(range: from..256) }
    posts { Faker::Number.within(range: 1..256) }
    referrals { posts }
    subscriptions { posts }
  end
end
