FactoryBot.define do
  factory :push_notification do
    post
    device
    subscription

    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    thumbnail { 'https://ripplr.io/img/logo-black.png' }
    scheduled_to { nil }
    delivered_at { nil }
  end
end
