module InboxNotifications
  class DeliverMailer < ApiMailer
    template 'd-b8526b810a5541c9ab28f1e826228529'

    def perform(inbox_notification_id)
      @inbox_notification = InboxNotification.find_by(id: inbox_notification_id)
      return if @inbox_notification.blank?
      return if to.blank?

      mail.add_personalization(
        to: to,
        data: {
          inbox_name: inbox.name,
          inbox_url: app_inbox_url(inbox),
          author_name: post.author.name,
          author_url: app_profile_url(post.author),
          topic_name: post.topic.name,
          topic_url: app_topic_url(post.topic),
          post_title: post.title,
          post_image: post.image.attached? ? public_blob_url(post.image) : Post::DEFAULT_IMAGE,
          post_body: post.body,
          post_url: post.url,
          post_ripplr_url: app_post_url(post)
        }
      )

      mail.deliver

      @inbox_notification.touch(:delivered_at)
    end

    private

    def to
      @inbox_notification.channel.channelable&.email
    end

    def inbox
      @inbox_notification.inbox
    end

    def post
      @inbox_notification.inbox_item.inboxable
    end
  end
end
