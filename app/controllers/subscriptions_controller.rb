class SubscriptionsController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  serializer include: [:subscribable]

  def index
    read_resource(@subscriptions)
  end

  def create
    @subscription = Subscriptions::CreateService.new(@subscription)
    create_resource(@subscription)
  end

  def update
    @subscription.assign_attributes(subscription_params)
    update_resource(@subscription)
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
