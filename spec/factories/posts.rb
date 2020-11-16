FactoryBot.define do
  factory :post do
    author factory: :user
    topic

    title { Faker::Games::LeagueOfLegends.quote }
    url { Faker::Internet.url }
    body { Faker::Lorem.paragraph }
  end
end
