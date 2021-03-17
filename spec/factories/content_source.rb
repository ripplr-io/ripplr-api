FactoryBot.define do
  factory :content_source do
    user
    topic
    community
    feed_url { Faker::Internet.url }
  end
end
