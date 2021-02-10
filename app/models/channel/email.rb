class Channel
  class Email < ApplicationRecord
    include Channelable

    has_one :user, through: :channel

    delegate :email, to: :user
  end
end
