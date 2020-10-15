FactoryBot.define do
  factory :device do
    user
    name { Faker::Lorem.word }
    device_type { Device.device_types.values.sample }
    onesignal_id { Faker::Alphanumeric.alphanumeric }
    settings { Support::JsonResources.device_settings }
  end
end
