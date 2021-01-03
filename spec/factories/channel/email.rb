FactoryBot.define do
  factory :channel_email, class: Channel::Email do
    channel { association :channel, channelable: instance }
  end
end
