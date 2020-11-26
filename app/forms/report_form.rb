class ReportForm
  include ActiveModel::Model

  attr_accessor :post, :reason, :body

  validates :post, presence: true
  validates :reason, presence: true
  validates :body, presence: true
end
