FactoryBot.define do
  factory :post do
    author factory: :user
    topic
    profile { author&.profile }

    title { Faker::Games::LeagueOfLegends.quote }
    url { Faker::Internet.url }
    body { Faker::Lorem.paragraph }
  end
end
