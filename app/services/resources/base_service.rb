module Resources
  class BaseService
    attr_reader :resource

    delegate :errors, to: :@resource

    def initialize(resource)
      @resource = resource
    end

    def save
      raise NotImplementedError
    end

    def destroy
      raise NotImplementedError
    end
  end
end
