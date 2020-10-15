require 'spec_helper'

shared_examples_for :subscribable do
  it { is_expected.to have_many(:received_subscriptions) }
  it { is_expected.to have_many(:subscribers).through(:received_subscriptions).source(:user) }
end
