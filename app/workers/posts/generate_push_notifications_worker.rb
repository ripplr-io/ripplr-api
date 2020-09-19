class GeneratePushNotificationsWorker
  include Sidekiq::Worker

  def perform(post_id)
    @post = Post.find(post_id)
    @post.subscribers.each do |subscriber|

    end
  end
end
