require 'rails_helper'

RSpec.describe Ticket, type: :model do
  subject { build(:ticket) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to have_many_attached(:screenshots) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
end
