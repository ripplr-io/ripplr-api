FactoryBot.define do
  factory :topic do
    name { Faker::Games::LeagueOfLegends.location }
    description { Faker::Lorem.sentence }
    avatar { Faker::Internet.slug(glue: '-') }
    slug { name.parameterize }
  end
end
