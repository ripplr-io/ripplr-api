require 'rails_helper'

RSpec.describe Notification::NewComment, type: :model do
  subject { build(:notification_new_comment) }

  it_behaves_like :notifiable

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:comment) }
  it { is_expected.to have_one(:post).through(:comment) }
  it { is_expected.to have_one(:author).through(:comment) }
end
