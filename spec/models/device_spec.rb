require 'rails_helper'

RSpec.describe Device, type: :model do
  subject(:device) { build(:device) }

  it { is_expected.to be_valid }

  it { is_expected.to define_enum_for(:device_type).backed_by_column_of_type(:string) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to have_many(:push_notifications) }

  it { is_expected.to validate_presence_of(:device_type) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:onesignal_id) }
  it { is_expected.to validate_presence_of(:settings) }
end
