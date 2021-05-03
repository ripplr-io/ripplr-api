class Comment < ApplicationRecord
  include Ratable

  belongs_to :author, class_name: 'Profile', foreign_key: 'profile_id', inverse_of: :comments
  belongs_to :post
  belongs_to :comment, optional: true

  has_many :comments, dependent: :destroy

  transforms_with Comments::CopyParentPostTransformer

  validates :body, presence: true

  acts_as_paranoid
  counter_culture :comment, column_name: :replies_count, touch: true
  counter_culture :post, touch: true,
    column_name: proc { |model| model.comment.nil? ? :comments_count : nil },
    column_names: {
      Comment.where(comment: nil) => :comments_count
    }
end
