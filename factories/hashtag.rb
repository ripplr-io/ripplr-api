FactoryBot.define do
  factory :hashtag do
    sequence(:name) { |n| [Faker::Lorem.word, n].join }
  end
end
