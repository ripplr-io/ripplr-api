require 'spec_helper'

shared_examples_for :ratable do
  it { is_expected.to have_many(:ratings) }
end
