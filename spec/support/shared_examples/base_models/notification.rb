require 'spec_helper'

shared_examples_for :notification do
  it { is_expected.to belong_to(:user) }
end
