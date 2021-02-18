class SubscriptionInboxesController < ApplicationController
  include JsonApi::Crudable

  load_resource :inbox
  load_and_authorize_resource through: [:inbox]

  serializer include: ['subscription.subscribable']

  def index
    @subscription_inboxes = @subscription_inboxes
      .includes(subscription: :subscribable)

    read_resource(@subscription_inboxes)
  end
end
