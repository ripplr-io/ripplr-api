require 'spec_helper'

shared_examples_for :followable do
  it { is_expected.to have_many(:received_follows) }
  it { is_expected.to have_many(:followers).through(:received_follows).source(:user) }
  it { is_expected.to have_many(:follower_profiles).through(:followers).source(:profile) }
end
