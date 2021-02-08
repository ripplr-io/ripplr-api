class Channel
  class Device < ApplicationRecord
    include Channelable

    validates :onesignal_id, presence: true
  end
end
