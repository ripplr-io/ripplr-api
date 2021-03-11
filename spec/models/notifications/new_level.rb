require 'rails_helper'

RSpec.describe Notifications::NewLevel, type: :model do
  subject { build(:new_level) }

  it { is_expected.to be_valid }

  it_behaves_like :notification
end
