require 'rails_helper'

RSpec.describe Users::AnonymizeWorker, type: :worker do
  it 'skips active users' do
    user = create(:user, profile: build(:profile, name: 'Name'))

    described_class.new.perform(user.id)

    expect(user.reload.profile.name).to eq('Name')
  end

  it 'anonymizes destroyed users' do
    user = create(:user, profile: build(:profile, name: 'Name'))
    profile = user.profile
    user.destroy

    described_class.new.perform(user.id)

    expect(user.reload.email).to start_with('del_')
    expect(profile.reload.name).to eq('Deleted Account')
  end
end
