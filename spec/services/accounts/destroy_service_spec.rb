require 'rails_helper'

RSpec.describe Accounts::DestroyService, type: :service do
  it 'accepts a user and comment' do
    user = create(:user)

    service = described_class.new(user, 'comment')

    expect(service.instance_variable_get(:@comment)).to eq('comment')
  end

  it 'destroys the user' do
    # FIXME: Move this to a global config
    ActiveJob::Base.queue_adapter = :test
    user = create(:user)

    described_class.new(user, 'comment').destroy

    expect(user.destroyed?).to be true
    # FIXME: verify params
    expect(ActionMailer::MailDeliveryJob).to have_been_enqueued
  end
end
