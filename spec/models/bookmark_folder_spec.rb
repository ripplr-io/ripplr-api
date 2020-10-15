require 'rails_helper'

RSpec.describe BookmarkFolder, type: :model do
  subject(:bookmark_folder) { build(:bookmark_folder) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:bookmark_folder).optional }

  it { is_expected.to have_many(:bookmark_folders) }
  it { is_expected.to have_many(:bookmarks) }

  it { is_expected.to validate_presence_of(:name) }
end
