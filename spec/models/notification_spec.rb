require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject(:notification) { build(:notification) }

  it { is_expected.to be_valid }

  it { is_expected.to define_enum_for(:notification_type).backed_by_column_of_type(:string) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:notification_type) }
  it { is_expected.to validate_presence_of(:data) }
end
