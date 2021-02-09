FactoryBot.define do
  factory :channel do
    for_device
    user
    sequence(:name) { |n| [Faker::Lorem.word, n].join }

    trait :for_device do
      channelable factory: :channel_device
    end

    trait :for_email do
      channelable factory: :channel_email
    end
  end
end
