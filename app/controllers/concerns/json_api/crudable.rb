# FIXME: improve this to work better with services and controller yields
module JsonApi
  module Crudable
    extend ActiveSupport::Concern

    def read_resource(resource)
      render_resources(resource)
    end

    def create_resource(resource)
      return render_errors(resource) unless resource.save

      resource = resource.resource if resource.is_a?(Resources::BaseService)
      render_resources(resource, status: :created)
    end

    def update_resource(resource)
      return render_errors(resource) unless resource.save

      resource = resource.resource if resource.is_a?(Resources::BaseService)
      render_resources(resource)
    end

    def destroy_resource(resource)
      return render_errors(resource) unless resource.destroy

      head :no_content
    end
  end
end
