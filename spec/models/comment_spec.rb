require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build(:comment) }

  it { is_expected.to be_valid }

  it_behaves_like :ratable

  it { is_expected.to belong_to(:author) }
  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:comment).optional }

  it { is_expected.to have_many(:comments) }

  it { is_expected.to validate_presence_of(:body) }
end
