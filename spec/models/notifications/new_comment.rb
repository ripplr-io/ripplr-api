require 'rails_helper'

RSpec.describe Notifications::NewComment, type: :model do
  subject { build(:new_comment) }

  it { is_expected.to be_valid }

  it_behaves_like :notification
end
