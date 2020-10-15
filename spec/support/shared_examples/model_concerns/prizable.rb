require 'spec_helper'

shared_examples_for :prizable do
  it { is_expected.to have_many(:prizes) }
end
