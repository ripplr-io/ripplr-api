class ChannelEmailSerializer < ApplicationSerializer
  attribute :email do |object|
    object.channel.user.email
  end
end
