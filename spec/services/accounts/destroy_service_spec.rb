require 'rails_helper'

RSpec.describe Accounts::DestroyService, type: :service do
  it 'accepts a user and comment' do
    user = create(:user)

    service = described_class.new(user, 'comment')

    expect(service.instance_variable_get(:@comment)).to eq('comment')
  end

  it 'destroys the user' do
    user = create(:user)

    described_class.new(user, 'comment').destroy

    expect(Sidekiq::Queues['mailers'].size).to eq 1
    expect(Users::AnonymizeWorker.jobs.size).to eq(1)
    expect(User.count).to eq 0
  end
end
