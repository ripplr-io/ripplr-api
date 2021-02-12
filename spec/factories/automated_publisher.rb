FactoryBot.define do
  factory :automated_publisher do
    user
    topic
    feed_url { Faker::Internet.url }
  end
end
