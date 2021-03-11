require 'rails_helper'

RSpec.describe BookmarkFolder, type: :model do
  subject { build(:bookmark_folder) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:bookmark_folder).optional }

  it { is_expected.to have_many(:bookmark_folders) }
  it { is_expected.to have_many(:bookmarks) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to([:bookmark_folder_id, :user_id]) }
end
