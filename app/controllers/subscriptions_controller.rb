class SubscriptionsController < ApplicationController
  include Crudable

  load_and_authorize_resource

  def index
    read_resource(@subscriptions, included_associations: [:subscribable])
  end

  # TODO: Use cancancan
  def create
    @subscription = Subscriptions::CreateService.new(subscription_params.merge(user: current_user))
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

  def subscription_params
    params.permit(:subscribable_id).merge(
      settings: JSON.parse(params[:settings] || '{}'),
      subscribable_type: params[:subscribable_type]&.capitalize
    )
  end
end
