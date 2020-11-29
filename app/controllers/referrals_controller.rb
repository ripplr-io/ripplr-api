class ReferralsController < ApplicationController
  include Crudable

  load_and_authorize_resource
  skip_load_resource only: :create

  def index
    read_resource(@referrals)
  end

  def show
    read_resource(@referral)
  end

  # FIXME: Make this restful & use cancancan
  def create
    new_referral_ids = referral_params[:referrals].map do |data|
      referral = Referral.new(data.merge(inviter: current_user))
      service = Referrals::CreateService.new(referral)
      service.resource.id if service.save
    end.compact

    read_resource(current_user.referrals.where(id: new_referral_ids))
  end

  def destroy
    destroy_resource(@referral)
  end

  private

  def referral_params
    params.permit(referrals: [:name, :email])
  end
end
