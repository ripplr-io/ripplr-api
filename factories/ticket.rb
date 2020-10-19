FactoryBot.define do
  factory :ticket do
    user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
  end
end
