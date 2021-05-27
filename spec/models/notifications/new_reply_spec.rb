require 'rails_helper'

RSpec.describe Notifications::NewReply, type: :model do
  subject { build(:new_reply) }

  it_behaves_like :notification

  it { is_expected.to be_valid }
end
