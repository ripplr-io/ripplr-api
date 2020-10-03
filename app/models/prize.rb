class Prize < ApplicationRecord
  belongs_to :prizable, polymorphic: true
  belongs_to :user

  validates :name, presence: true
  validates :points, presence: true
end
