class TrackController < ApplicationController
  include JsonApi::Crudable

  authorize_resource class: :tracking

  def create
    Mixpanel::TrackAppEventWorker.perform_async(current_user.id, event_name, event_data) if event_name.present?
    head :no_content
  end

  private

  def event_name
    params[:event_name]
  end

  def event_data
    JSON.parse(params[:event_data]) if params[:event_data].present?
  end
end
