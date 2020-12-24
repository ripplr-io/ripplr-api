class Billing < ApplicationRecord
  belongs_to :user

  acts_as_paranoid
end
