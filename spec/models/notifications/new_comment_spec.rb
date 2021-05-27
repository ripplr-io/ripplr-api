require 'rails_helper'

RSpec.describe Notifications::NewComment, type: :model do
  subject { build(:new_comment) }

  it_behaves_like :notification

  it { is_expected.to be_valid }
end
