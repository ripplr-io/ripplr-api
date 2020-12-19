module Resources
  class Save < ApplicationInteractor
    def call
      context.fail! unless context.resource.save
    end
  end
end
