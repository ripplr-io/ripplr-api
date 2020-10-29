module Resources
  class UpdateService < BaseService
    def initialize(resource, attributes)
      resource.assign_attributes(attributes)
      super(resource)
    end

    def save
      raise NotImplementedError
    end
  end
end
