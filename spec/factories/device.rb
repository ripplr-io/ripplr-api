FactoryBot.define do
  factory :device do
    user
    sequence(:name) { |n| [Faker::Lorem.word, n].join }
    device_type { Device.device_types.values.sample }
    onesignal_id { Faker::Alphanumeric.alphanumeric }
    settings { '{}' }
  end
end
