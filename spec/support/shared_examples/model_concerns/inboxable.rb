require 'spec_helper'

shared_examples_for :inboxable do
  it { is_expected.to have_many(:inbox_items) }
  it { is_expected.to have_many(:inboxes).through(:inbox_items) }
end
