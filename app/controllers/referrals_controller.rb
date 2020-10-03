class ReferralsController < ApplicationController
  def create
    referral_params[:referrals].each do |data|
      current_user.referrals.create!(data)
    end
  end

  private

  def referral_params
    params.permit(referrals: [:name, :email])
  end
end
