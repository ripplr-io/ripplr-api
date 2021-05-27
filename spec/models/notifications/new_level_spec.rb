require 'rails_helper'

RSpec.describe Notifications::NewLevel, type: :model do
  subject { build(:new_level) }

  it_behaves_like :notification

  it { is_expected.to be_valid }
end
