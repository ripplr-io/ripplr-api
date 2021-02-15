require 'rails_helper'

RSpec.describe AutomatedPublisher, type: :model do
  subject(:automated_publisher) { build(:automated_publisher) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:topic) }

  it { is_expected.to validate_presence_of(:feed_url) }
end
