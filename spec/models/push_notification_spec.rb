require 'rails_helper'

RSpec.describe PushNotification, type: :model do
  subject(:push_notification) { build(:push_notification) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:device) }
  it { is_expected.to belong_to(:subscription) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:thumbnail) }
end
