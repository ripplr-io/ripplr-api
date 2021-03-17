FactoryBot.define do
  factory :content_source do
    user
    community
    feed_url { Faker::Internet.url }
  end
end
