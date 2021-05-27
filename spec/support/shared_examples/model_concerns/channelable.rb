require 'spec_helper'

shared_examples_for :channelable do
  it { is_expected.to have_one(:channel) }
end
