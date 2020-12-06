module Posts
  class ProxiesController < ApplicationController
    load_and_authorize_resource :post

    def show
      Mixpanel::TrackPostViewWorker.perform_async(current_user.id, @post.id) if current_user.present?
      redirect_to @post.url
    end
  end
end
