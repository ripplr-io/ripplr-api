FactoryBot.define do
  factory :channel_device, class: Channel::Device do
    channel { association :channel, channelable: instance }
    onesignal_id { Faker::Alphanumeric.alphanumeric }
  end
end
