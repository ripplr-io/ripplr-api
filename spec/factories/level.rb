FactoryBot.define do
  factory :level do
    sequence(:name) { |n| [Faker::Lorem.word, n].join }
    from { Faker::Number.within(range: 1..255) }
    to { Faker::Number.within(range: from..256) }
    posts { Faker::Number.within(range: 3..256) }
    referrals { posts }
    subscriptions { posts }
  end
end
