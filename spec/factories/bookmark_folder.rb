FactoryBot.define do
  factory :bookmark_folder do
    user
    bookmark_folder { nil }
    sequence(:name) { |n| [Faker::Lorem.word, n].join }
  end
end
