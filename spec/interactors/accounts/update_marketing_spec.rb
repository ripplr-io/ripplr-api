require 'rails_helper'

RSpec.describe Accounts::UpdateMarketing, type: :interactor do
  it 'updates the account' do
    user = create(:user, subscribed_to_marketing: false)
    user.subscribed_to_marketing = true

    described_class.call(resource: user)

    expect(user.reload.subscribed_to_marketing).to eq true
    expect(Sendgrid::SyncUserWorker.jobs.size).to eq(1)
  end
end
