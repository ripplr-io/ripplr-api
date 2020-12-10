require 'rails_helper'

RSpec.describe Sendgrid::SyncUserWorker, type: :worker do
  it 'calls the sendgrid service' do
    expect_any_instance_of(Sendgrid::BaseService).to receive(:sync_user)

    described_class.new.perform(create(:user).id)
  end
end
