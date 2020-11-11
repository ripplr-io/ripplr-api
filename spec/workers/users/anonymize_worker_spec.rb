require 'rails_helper'

RSpec.describe Users::AnonymizeWorker, type: :worker do
  it 'skips active users' do
    user = create(:user, name: 'Name')

    described_class.new.perform(user.id)

    expect(user.reload.name).to eq('Name')
  end

  it 'anonymizes destroyed users' do
    user = create(:user, name: 'Name')
    user.destroy

    described_class.new.perform(user.id)

    expect(user.reload.name).to eq('Disabled Account')
  end
end
