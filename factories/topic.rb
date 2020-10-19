FactoryBot.define do
  factory :topic do
    sequence(:name) { |n| [Faker::Lorem.word, n].join }
    description { Faker::Lorem.sentence }
    avatar { Faker::Internet.slug(glue: '-') }
    slug { name.parameterize }
  end
end
