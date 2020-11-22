module Posts
  class BroadcastCreationWorker < ApplicationWorker
    def perform(post_id)
      post = Post.find_by(id: post_id)
      return if post.blank?

      data = {
        type: :new_post,
        payload: PostSerializer.new(post, { include: [:author, :topic, :hashtags] })
      }

      TopicChannel.broadcast_to(post.topic, data)
      ProfileChannel.broadcast_to(post.author, data)
      post.hashtags.each { |hashtag| HashtagChannel.broadcast_to(hashtag, data) }
      post.followers.each { |user| UserChannel.broadcast_to(user, data) }
    end
  end
end
