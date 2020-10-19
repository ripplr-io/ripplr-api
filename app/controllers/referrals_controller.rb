class ReferralsController < ApplicationController
  include Crudable

  def index
    render json: current_user.referrals
  end

  # TODO: Make this restful
  def create
    referral_params[:referrals].each do |data|
      current_user.referrals.create!(data)
    end
  end

  def destroy
    @referral = current_user.referrals.find(params[:id])
    destroy_resource(@referral)
  end

  private

  def referral_params
    params.permit(referrals: [:name, :email])
  end
end
