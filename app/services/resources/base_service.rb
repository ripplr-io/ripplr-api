module Resources
  class BaseService
    attr_reader :resource

    delegate :errors, to: :@resource

    def initialize(resource)
      @resource = resource
    end
  end
end
