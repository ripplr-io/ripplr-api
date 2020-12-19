module Resources
  class Destroy < ApplicationInteractor
    def call
      context.fail! unless context.resource.destroy
    end
  end
end
