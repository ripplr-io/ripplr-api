module Posts
  class GenerateInboxItemsWorker < ApplicationWorker
    def perform(post_id)
      post = Post.find_by(id: post_id)
      return if post.blank?

      post.candidate_inboxes.each do |inbox|
        next unless Inboxes::FilterService.new(inbox).allowed_topic?(post.topic)

        inbox_item = inbox.inbox_items.create(inboxable: post)
        InboxItems::GenerateInboxNotificationsWorker.perform_async(inbox_item.id)
      end
    end
  end
end
