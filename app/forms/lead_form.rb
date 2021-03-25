class LeadForm
  include ActiveModel::Model

  attr_accessor :email

  validates :email, presence: true, email: true
end
