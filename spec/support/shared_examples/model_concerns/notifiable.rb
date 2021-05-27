require 'spec_helper'

shared_examples_for :notifiable do
  it { is_expected.to have_one(:notification) }
end
