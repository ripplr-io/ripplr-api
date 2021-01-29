module Referrals
  class InviteMailer < ApiMailer
    template 'd-0fa884a3213d4f9bbf4e5cf4d50e803a'

    def perform(referral_id)
      referral = Referral.find_by(id: referral_id)
      return if referral.blank?

      mail.add_personalization(
        to: referral.email,
        data: {
          inviter_name: referral.inviter.name,
          sign_up_url: app_sign_up_url(referral.id)
        }
      )

      mail.deliver
    end
  end
end
