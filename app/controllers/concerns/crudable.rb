# FIXME: improve this to work better with services and controller yields
module Crudable
  extend ActiveSupport::Concern

  private

  def read_resource(resource, included_associations: [])
    render_resources(resource, included_associations)
  end

  def create_resource(resource, included_associations: [])
    return render_errors(resource) unless resource.save

    resource = resource.resource if resource.is_a?(Resources::BaseService)
    render_resources(resource, included_associations, status: :created)
  end

  def update_resource(resource, included_associations: [])
    return render_errors(resource) unless resource.save

    resource = resource.resource if resource.is_a?(Resources::BaseService)
    render_resources(resource, included_associations)
  end

  def destroy_resource(resource)
    return render_errors(resource) unless resource.destroy

    head :no_content
  end

  def render_resources(resource, included_associations, status: :ok)
    options = {}
    options[:include] = included_associations
    options[:params] = { current_user: current_user }

    render json: DynamicSerializer.new(resource, options), status: status
  end

  def render_errors(resource)
    render json: ErrorSerializer.serialize(resource.errors), status: :unprocessable_entity
  end
end
