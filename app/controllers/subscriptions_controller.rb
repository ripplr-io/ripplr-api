class SubscriptionsController < ApplicationController
  include Crudable

  before_action :doorkeeper_authorize!
  before_action :find_subscription, only: [:update, :destroy]

  def index
    read_resource(current_user.subscriptions, included_associations: [:subscribable])
  end

  def create
    @subscription = current_user.subscriptions.new(subscription_params)
    create_resource(@subscription, included_associations: [:subscribable])
  end

  def update
    @subscription.assign_attributes(subscription_params)
    update_resource(@subscription, included_associations: [:subscribable])
  end

  def destroy
    destroy_resource(@subscription)
  end

  private

  def find_subscription
    @subscription = current_user.subscriptions.find(params[:id])
  end

  def subscription_params
    params.permit(:subscribable_id).merge!(
      settings: JSON.parse(params[:settings] || '{}'),
      subscribable_type: params[:subscribable_type]&.capitalize
    )
  end
end
