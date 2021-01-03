class ChannelSerializer < ApplicationSerializer
  belongs_to :user
  belongs_to :channelable, polymorphic: {
    Channel::Device => :channel_device,
    Channel::Email => :channel_email
  }

  attributes :name, :settings, :created_at, :updated_at
end
