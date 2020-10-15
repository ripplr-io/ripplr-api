FactoryBot.define do
  factory :bookmark_folder do
    user
    bookmark_folder { nil }
    name { Faker::Lorem.word }
  end
end
