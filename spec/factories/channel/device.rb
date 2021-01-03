FactoryBot.define do
  factory :channel_device, class: Channel::Device do
    channel { association :channel, channelable: instance }
    device_type { Device.device_types.values.sample }
    onesignal_id { Faker::Alphanumeric.alphanumeric }
  end
end
