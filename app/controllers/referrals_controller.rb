class ReferralsController < ApplicationController
  include Crudable

  before_action :authenticate_user!, except: :show

  def index
    read_resource(current_user.referrals)
  end

  def show
    @referral = Referral.find(params[:id])
    read_resource(@referral)
  end

  # FIXME: Make this restful
  def create
    referral_params[:referrals].each do |data|
      Referrals::CreateService.new(data.merge!(inviter: current_user)).save
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
