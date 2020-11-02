class ReferralMailer < ApplicationMailer
  helper :routes

  def invite
    @referral = params[:referral]
    mail(to: @referral.email, subject: "#{@referral.inviter.name} has invited to join Ripplr")
  end
end
