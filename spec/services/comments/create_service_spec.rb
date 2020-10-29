require 'rails_helper'

RSpec.describe Comments::CreateService, type: :service do
  it 'creates the comment' do
    comment_params = {
      body: 'Body',
      post: create(:post),
      author: create(:user)
    }

    expect { described_class.new(comment_params).save }
      .to change { Comment.count }.by(1)
      .and change { Notifications::NewComment.count }
  end

  context 'generating notifications for comments' do
    it 'notifies the post author' do
      post = create(:post)
      comment_params = {
        body: 'Body',
        post: post,
        author: create(:user)
      }

      expect { described_class.new(comment_params).save }
        .to change { Notifications::NewComment.count }.by(1)
        .and change { Notifications::NewReply.count }.by(0)

      expect(Notifications::NewComment.last.user).to eq(post.author)
    end

    it 'does not notify the resource author' do
      post = create(:post)
      comment_params = {
        body: 'Body',
        post: post,
        author: post.author
      }

      expect { described_class.new(comment_params).save }
        .to change { Notifications::NewComment.count }.by(0)
        .and change { Notifications::NewReply.count }.by(0)
    end
  end

  context 'generating notifications for replies' do
    it 'notifies the comment author' do
      comment = create(:comment)
      reply_params = {
        body: 'Body',
        comment: comment,
        author: create(:user)
      }

      expect { described_class.new(reply_params).save }
        .to change { Notifications::NewComment.count }.by(0)
        .and change { Notifications::NewReply.count }.by(1)

      expect(Notifications::NewReply.last.user).to eq(comment.author)
    end

    it 'does not notify the resource author' do
      comment = create(:comment)
      reply_params = {
        body: 'Body',
        comment: comment,
        author: comment.author
      }

      expect { described_class.new(reply_params).save }
        .to change { Notifications::NewComment.count }.by(0)
        .and change { Notifications::NewReply.count }.by(0)
    end

    it 'notifies the comment repliers' do
      comment = create(:comment)
      replies = create_list(:reply, 2, comment: comment)
      reply_params = {
        body: 'Body',
        comment: comment,
        author: comment.author
      }

      expect { described_class.new(reply_params).save }
        .to change { Notifications::NewComment.count }.by(0)
        .and change { Notifications::NewReply.count }.by(2)

      notification_user_ids = Notifications::NewReply.last(2).pluck(:user_id)
      reply_user_ids = replies.pluck(:author_id)
      expect(notification_user_ids - reply_user_ids).to be_empty
    end

    it 'notifies the comment author/repliers only once' do
      comment = create(:comment)
      reply = create(:reply, comment: comment, author: comment.author)
      reply_params = {
        body: 'Body',
        comment: comment,
        author: create(:user)
      }

      expect { described_class.new(reply_params).save }
        .to change { Notifications::NewComment.count }.by(0)
        .and change { Notifications::NewReply.count }.by(1)

      expect(Notifications::NewReply.last.user).to eq(reply.author)
    end
  end
end
