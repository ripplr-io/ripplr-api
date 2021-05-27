class Notification
  class NewComment < ApplicationRecord
    include Notifiable

    belongs_to :comment
    has_one :post, through: :comment
    has_one :author, through: :comment

    def to_data
      {
        type: 'new_comment',
        id: comment_id,
        post_id: post_id,
        author_id: author_id
      }
    end
  end
end
