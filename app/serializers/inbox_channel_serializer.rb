class InboxChannelSerializer < ApplicationSerializer
  attributes :settings, :created_at, :updated_at

  has_one :channel
end
