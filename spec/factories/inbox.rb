FactoryBot.define do
  factory :inbox do
    user
    sequence(:name) { |n| [Faker::Lorem.word, n].join }
    description { Faker::Hipster.paragraph }
    settings { Support::JsonResources.subscription_settings }
  end
end
