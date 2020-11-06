class ReferralsController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!, except: :show

  def index
    read_resource(current_user.referrals)
  end

  def show
    @referral = Referral.find(params[:id])
    read_resource(@referral)
  end

  # FIXME: Make this restful
  def create
    new_referrals = referral_params[:referrals].map do |data|
      service = Referrals::CreateService.new(data.merge!(inviter: current_user))
      service.resource if service.save
    end
    read_resource(new_referrals.compact)
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
