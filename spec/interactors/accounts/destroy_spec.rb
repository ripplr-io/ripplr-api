require 'rails_helper'

RSpec.describe Accounts::Destroy, type: :interactor do
  it 'destroys the user' do
    user = create(:user)

    described_class.call(resource: user, comment: 'comment')

    expect(Support::AccountDeletedMailer.jobs.size).to eq(1)
    expect(Users::AnonymizeWorker.jobs.size).to eq(1)
    expect(User.count).to eq 0
  end
end
