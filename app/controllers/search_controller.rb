class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    search = Search::SearchService.new(params[:query], params[:page], params[:per_page])
    search.add_posts_filter(current_user.following_user_post_ids) if filter_by?('user')
    search.add_posts_filter(current_user.following_topic_post_ids) if filter_by?('topic')
    search.add_posts_filter(current_user.following_hashtag_post_ids) if filter_by?('hashtag')

    results =
      if params[:vertical] == 'everything'
        search.grouped_results
      else
        search.individual_results(params[:vertical])
      end

    render json: { data: serialize_results(results) }, status: :ok
  end

  private

  def filter_by?(record_type)
    params[record_type] == 'following'
  end

  def serialize_results(data)
    data.transform_values do |value|
      (value || []).map do |object|
        ActiveModelSerializers::SerializableResource.new(object)
      end
    end
  end
end
