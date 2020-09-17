class SubscriptionsController < ApplicationController
  before_action :find_subscription, only: [:update, :destroy]

  def index
    data = ActiveModelSerializers::SerializableResource.new(current_user.subscriptions).as_json
    render json: { data: data }
  end

  def create
    # TODO: replace with strong params
    current_user.subscriptions.create(
      subscribable_id: params[:subscribable_id],
      subscribable_type: params[:subscribable_type].capitalize,
      settings: params[:settings]
    )
  end

  def update
    @subscription.update(subscription_params)
  end

  def destroy
    @subscription.destroy
  end

  private

  def find_subscription
    @subscription = current_user.subscriptions.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:subscribable_id, :subscribable_type, :settings)
  end
end
