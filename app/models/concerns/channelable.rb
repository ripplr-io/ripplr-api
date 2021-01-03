module Channelable
  extend ActiveSupport::Concern

  included do
    has_one :channel, as: :channelable, touch: true, dependent: :destroy
  end
end
