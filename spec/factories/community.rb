FactoryBot.define do
  factory :community do
    owner factory: :user
    sequence(:name) { |n| [Faker::Lorem.word, n].join }
    slug { name.parameterize }
    description { Faker::Lorem.paragraph }

    topics do
      [
        build(:topic)
      ]
    end
  end
end
