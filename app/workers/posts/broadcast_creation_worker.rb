module Posts
  class BroadcastCreationWorker
    include Sidekiq::Worker

    def perform(post_id)
      post = Post.find_by(id: post_id)
      return if post.blank?

      data = {
        type: :new_post,
        payload: ActiveModelSerializers::SerializableResource.new(post)
      }

      TopicChannel.broadcast_to(post.topic, data)
      ProfileChannel.broadcast_to(post.author, data)
      post.hashtags.each { |hashtag| HashtagChannel.broadcast_to(hashtag, data) }
    end
  end
end
