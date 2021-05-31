require 'rails_helper'

RSpec.describe Notification::NewRating, type: :model do
  subject { build(:notification_new_rating) }

  it_behaves_like :notifiable

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:ratable) }
end
