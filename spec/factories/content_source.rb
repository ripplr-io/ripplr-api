FactoryBot.define do
  factory :content_source do
    user
    topic
    feed_url { Faker::Internet.url }
  end
end
