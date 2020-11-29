# FIXME: improve this to work better with services and controller yields
module Crudable
  extend ActiveSupport::Concern

  private

  def read_resource(resource, serializer_options = {})
    render_resources(resource, serializer_options)
  end

  def create_resource(resource, serializer_options = {})
    return render_errors(resource) unless resource.save

    render_resources(resource, serializer_options, status: :created)
  end

  def update_resource(resource, serializer_options = {})
    return render_errors(resource) unless resource.save

    render_resources(resource, serializer_options)
  end

  def destroy_resource(resource)
    return render_errors(resource) unless resource.destroy

    head :no_content
  end

  def render_resources(resource, serializer_options, status: :ok)
    options = {}
    options[:include] = serializer_options[:included_associations]
    options[:params] = { current_user: current_user }

    serializer = serializer_options[:serializer] || DynamicSerializer
    resource = resource.resource if resource.is_a?(Resources::BaseService)

    render json: serializer.new(resource, options), status: status
  end

  def render_errors(resource)
    render json: ErrorSerializer.serialize(resource.errors), status: :unprocessable_entity
  end
end
