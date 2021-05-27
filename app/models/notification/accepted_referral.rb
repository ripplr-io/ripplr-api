class Notification
  class AcceptedReferral < ApplicationRecord
    include Notifiable

    belongs_to :referral
    has_one :invitee, through: :referral

    def to_data
      {
        type: 'referral_accepted',
        id: referral_id,
        author_id: invitee_id
      }
    end
  end
end
