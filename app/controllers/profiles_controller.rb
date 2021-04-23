class ProfilesController < ApplicationController
  include JsonApi::Crudable

  load_and_authorize_resource

  def show
    read_resource(@profile)
  end
end
