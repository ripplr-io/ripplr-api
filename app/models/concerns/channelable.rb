module Channelable
  extend ActiveSupport::Concern

  TYPES = ['Channel::Email', 'Channel::Device'].freeze

  included do
    has_one :channel, as: :channelable, touch: true, dependent: :destroy
  end
end
