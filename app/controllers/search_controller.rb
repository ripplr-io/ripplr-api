class SearchController < ApplicationController
  def index
    posts = Post.search(params[:query]) if params[:vertical] == 'posts' || params[:vertical] == 'everything'
    topics = Topic.search(params[:query]) if params[:vertical] == 'topics' || params[:vertical] == 'everything'
    hashtags = Hashtag.search(params[:query]) if params[:vertical] == 'hashtags' || params[:vertical] == 'everything'
    users = User.search(params[:query]) if params[:vertical] == 'users' || params[:vertical] == 'everything'

    posts = posts.merge(current_user.following_user_posts) if params['user'] == 'following'
    posts = posts.merge(current_user.following_topic_posts) if params['topic'] == 'following'
    posts = posts.merge(current_user.following_hashtag_posts) if params['hashtag'] == 'following'

    render json: {
      data: {
        posts: serialize(posts || []),
        topics: serialize(topics || []),
        hashtags: serialize(hashtags || []),
        users: serialize(users || [])
      }
    }, status: :ok
  end

  private

  def serialize(collection)
    collection.map do |object|
      ActiveModelSerializers::SerializableResource.new(object)
    end
  end
end
