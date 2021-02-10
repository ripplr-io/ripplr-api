FactoryBot.define do
  factory :channel do
    for_device
    user
    sequence(:name) { |n| [Faker::Lorem.word, n].join }

    trait :for_device do
      channelable { association :channel_device, channel: instance }
    end

    trait :for_email do
      channelable { association :channel_email, channel: instance }
    end
  end
end
