FactoryBot.define do
  factory :channel_device, class: Channel::Device do
    onesignal_id { Faker::Alphanumeric.alphanumeric }
  end
end
