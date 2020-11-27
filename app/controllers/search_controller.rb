class SearchController < ApplicationController
  authorize_resource class: :search

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
        options = {}

        # FIXME: We should use named serializers if we want to specify included associations
        options[:include] = [:author, :topic, :hashtags, :bookmark] if object.class.to_s == 'Post'

        DynamicSerializer.new(object, options)
      end
    end
  end
end
