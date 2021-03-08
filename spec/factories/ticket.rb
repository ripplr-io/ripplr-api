FactoryBot.define do
  factory :ticket do
    user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }

    trait :with_screenshots do
      screenshots do
        [
          Rack::Test::UploadedFile.new('spec/fixtures/logo.png', 'image/png')
        ]
      end
    end
  end
end
