require 'rails_helper'

RSpec.describe Comments::GenerateNotificationsWorker, type: :worker do
  context 'generating notifications for comments' do
    it 'notifies the post author' do
      comment = create(:comment)

      expect { described_class.new.perform(comment.id) }
        .to change { Notifications::NewComment.count }.by(1)
        .and change { Notification::NewComment.count }.by(1)
        .and change { Notifications::NewReply.count }.by(0)
        .and change { Notification::NewReply.count }.by(0)

      expect(Notifications::NewComment.last.user).to eq(comment.post.author.user)
    end

    it 'does not notify the resource author' do
      post = create(:post)
      comment = create(:comment, post: post, author: post.author)

      expect { described_class.new.perform(comment.id) }
        .to change { Notifications::NewComment.count }.by(0)
        .and change { Notification::NewComment.count }.by(0)
        .and change { Notifications::NewReply.count }.by(0)
        .and change { Notification::NewReply.count }.by(0)
    end
  end

  context 'generating notifications for replies' do
    it 'notifies the comment author' do
      reply = create(:reply)

      expect { described_class.new.perform(reply.id) }
        .to change { Notifications::NewComment.count }.by(0)
        .and change { Notification::NewComment.count }.by(0)
        .and change { Notifications::NewReply.count }.by(1)
        .and change { Notification::NewReply.count }.by(1)

      expect(Notifications::NewReply.last.user).to eq(reply.comment.author.user)
    end

    it 'does not notify the resource author' do
      comment = create(:comment)
      reply = create(:reply, comment: comment, author: comment.author)

      expect { described_class.new.perform(reply.id) }
        .to change { Notifications::NewComment.count }.by(0)
        .and change { Notification::NewComment.count }.by(0)
        .and change { Notifications::NewReply.count }.by(0)
        .and change { Notification::NewReply.count }.by(0)
    end

    it 'notifies the comment repliers' do
      comment = create(:comment)
      replies = create_list(:reply, 2, comment: comment)
      reply = create(:reply, comment: comment, author: comment.author)

      expect { described_class.new.perform(reply.id) }
        .to change { Notifications::NewComment.count }.by(0)
        .and change { Notification::NewComment.count }.by(0)
        .and change { Notifications::NewReply.count }.by(2)
        .and change { Notification::NewReply.count }.by(2)

      notification_user_ids = Notifications::NewReply.last(2).pluck(:user_id)
      reply_user_ids = replies.map(&:author).map(&:user_id)
      expect(notification_user_ids - reply_user_ids).to be_empty
    end

    it 'notifies the comment author/repliers only once' do
      comment = create(:comment)
      old_reply = create(:reply, comment: comment, author: comment.author)
      reply = create(:reply, comment: comment)

      expect { described_class.new.perform(reply.id) }
        .to change { Notifications::NewComment.count }.by(0)
        .and change { Notification::NewComment.count }.by(0)
        .and change { Notifications::NewReply.count }.by(1)
        .and change { Notification::NewReply.count }.by(1)

      expect(Notifications::NewReply.last.user).to eq(old_reply.author.user)
    end
  end
end
