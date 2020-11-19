class Comment < ApplicationRecord
  include Ratable

  belongs_to :author, class_name: :User
  belongs_to :post
  belongs_to :comment, optional: true

  has_many :comments, dependent: :destroy

  validates :body, presence: true

  before_validation :copy_parent_post

  scope :root_comments, -> { where(comment: nil) }
  scope :replies, -> { where.not(comment: nil) }

  acts_as_paranoid
  counter_culture :comment, column_name: :replies_count, touch: true
  counter_culture :post,
    column_name: proc { |model| model.comment.present? ? :comments_count : nil },
    column_names: {
      Comment.root_comments => :comments_count
    }

  private

  def copy_parent_post
    self.post = comment.post if comment.present?
  end
end
