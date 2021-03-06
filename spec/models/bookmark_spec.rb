require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  subject { build(:bookmark) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:bookmark_folder) }

  it { is_expected.to validate_uniqueness_of(:post_id).scoped_to(:user_id).case_insensitive }
end
