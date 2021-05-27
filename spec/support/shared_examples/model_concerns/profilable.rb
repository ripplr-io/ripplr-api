require 'spec_helper'

shared_examples_for :profilable do
  it { is_expected.to have_one(:profile) }
end
