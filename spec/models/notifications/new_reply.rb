require 'rails_helper'

RSpec.describe Notifications::NewReply, type: :model do
  subject(:new_reply) { build(:new_reply) }

  it { is_expected.to be_valid }

  it_behaves_like :notification
end
