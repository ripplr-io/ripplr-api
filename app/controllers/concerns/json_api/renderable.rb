module JsonApi
  module Renderable
    extend ActiveSupport::Concern

    included do
      class_attribute :serializer_class, :serializer_include
    end

    class_methods do
      def serializer(options = {})
        self.serializer_class = options[:class]
        self.serializer_include = options[:include]
      end
    end

    private

    def render_resources(resource, status: :ok)
      options = {}
      options[:include] = serializer_include
      options[:params] = { current_user: current_user }

      serializer = serializer_class || DynamicSerializer

      render json: serializer.new(resource, options), status: status
    end

    def render_errors(resource)
      render json: ErrorSerializer.serialize(resource.errors), status: :unprocessable_entity
    end
  end
end
