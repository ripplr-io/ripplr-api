class SubscriptionsController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  serializer include: [:subscribable, :inboxes]

  def index
    read_resource(@subscriptions)
  end

  def create
    create_resource(@subscription, interactor: Subscriptions::Create)
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
    ).merge(inbox_params)
  end

  def inbox_params
    return {} if params[:inbox_ids].blank?

    { inboxes: current_user.inboxes.where(id: params[:inbox_ids]) }
  end
end
