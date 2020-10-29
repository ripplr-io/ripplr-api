# TODO: improve this to work better with services
module Crudable
  extend ActiveSupport::Concern

  private

  def read_resource(resource, included_associations: [])
    render json: resource, include: included_associations, status: :ok
  end

  def create_resource(resource, included_associations: [])
    return render_errors(resource) unless resource.save

    resource = resource.resource if resource.is_a?(Resources::BaseService)
    render json: resource, include: included_associations, status: :created
  end

  def update_resource(resource, included_associations: [])
    return render_errors(resource) unless resource.save

    resource = resource.resource if resource.is_a?(Resources::BaseService)
    render json: resource, include: included_associations, status: :ok
  end

  def destroy_resource(resource)
    return render_errors(resource) unless resource.destroy

    head :no_content
  end

  def render_errors(resource)
    render json: ErrorSerializer.serialize(resource.errors), status: :unprocessable_entity
  end
end
