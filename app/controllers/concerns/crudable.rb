module Crudable
  extend ActiveSupport::Concern

  private

  def create_resource(resource, included_associations: [])
    return render_errors(resource) unless resource.save

    yield if block_given?

    render json: resource, include: included_associations, status: :created
  end

  def update_resource(resource, included_associations: [])
    return render_errors(resource) unless resource.save

    yield if block_given?

    render json: resource, include: included_associations, status: :ok
  end

  def destroy_resource(resource)
    return render_errors(resource) unless resource.destroy

    yield if block_given?

    head :no_content
  end

  def render_errors(resource)
    render json: ErrorSerializer.serialize(resource.errors), status: :unprocessable_entity
  end
end
