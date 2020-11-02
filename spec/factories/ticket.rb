FactoryBot.define do
  factory :ticket do
    user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }

    trait :with_screenshots do
      after :create do |ticket|
        ticket.screenshots.attach(
          io: File.open('spec/factories/resources/ticket_screenshot.png'),
          filename: 'ticket_screenshot.png'
        )
      end
    end
  end
end
