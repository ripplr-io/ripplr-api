require 'rails_helper'

RSpec.describe ContentSource, type: :model do
  subject(:content_source) { build(:content_source) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:topic) }

  it { is_expected.to validate_presence_of(:feed_url) }
end
