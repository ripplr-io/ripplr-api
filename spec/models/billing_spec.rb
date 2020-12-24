require 'rails_helper'

RSpec.describe Billing, type: :model do
  subject(:billing) { build(:billing) }

  it { is_expected.to be_valid }
end
