FactoryBot.define do
  factory :inbox do
    user
    sequence(:name) { |n| [Faker::Lorem.word, n].join }
    settings { Support::JsonResources.subscription_settings }
  end
end
