module JsonApi
  module Crudable
    extend ActiveSupport::Concern

    def read_resource(resource)
      render_resources(resource)
    end

    def create_resource(resource, interactor: Resources::Save, context: {})
      result = interactor.call(context.merge(resource: resource))

      render_result(result) do
        render_resources(result.resource, status: :created)
      end
    end

    def update_resource(resource, interactor: Resources::Save, context: {})
      result = interactor.call(context.merge(resource: resource))

      render_result(result) do
        render_resources(result.resource)
      end
    end

    def destroy_resource(resource, interactor: Resources::Destroy, context: {})
      result = interactor.call(context.merge(resource: resource))

      render_result(result) do
        head :no_content
      end
    end

    private

    def render_result(result)
      return render_errors(result.resource.errors) unless result.success?

      yield
    end
  end
end
