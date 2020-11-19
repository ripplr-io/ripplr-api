class Comment < ApplicationRecord
  include Ratable

  belongs_to :author, class_name: :User
  belongs_to :post
  belongs_to :comment, optional: true

  has_many :comments, dependent: :destroy

  validates :body, presence: true

  before_validation :copy_parent_post

  acts_as_paranoid
  counter_culture :comment, column_name: :replies_count, touch: true
  counter_culture :post, touch: true,
    column_name: proc { |model| model.comment.nil? ? :comments_count : nil },
    column_names: {
      Comment.where(comment: nil) => :comments_count
    }

  private

  def copy_parent_post
    self.post = comment.post if comment.present?
  end
end
