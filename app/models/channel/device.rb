class Channel
  class Device < ApplicationRecord
    include Channelable

    enum device_type: {
      computer: 'Computer',
      smartphone: 'Smartphone',
      tablet: 'Tablet'
    }

    validates :device_type, presence: true
    validates :onesignal_id, presence: true
  end
end
