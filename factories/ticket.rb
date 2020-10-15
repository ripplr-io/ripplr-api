FactoryBot.define do
  factory :ticket do
    user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }

    # TODO: Fix this trait in for samples
    trait :with_screenshots do
      transient do
        screenshots_count { 2 }
      end

      screenshots do
        filename = Rails.root.join('factories', 'resources', 'ticket_screenshot.png')
        Array.new(screenshots_count) { Rack::Test::UploadedFile.new(filename, 'image/png') }
      end
    end
  end
end
