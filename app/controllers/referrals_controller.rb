class ReferralsController < ApplicationController
  def index
    data = ActiveModelSerializers::SerializableResource.new(current_user.referrals).as_json
    render json: { data: data }
  end

  def create
    referral_params[:referrals].each do |data|
      current_user.referrals.create!(data)
    end
  end

  def destroy
    current_user.referrals.find(params[:id]).destroy!
  end

  private

  def referral_params
    params.permit(referrals: [:name, :email])
  end
end
