require 'rails_helper'

RSpec.describe Billing, type: :model do
  subject { build(:billing) }

  it { is_expected.to be_valid }
end
