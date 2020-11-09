require 'rails_helper'

RSpec.describe Users::UpdateLevelWorker, type: :worker do
  it 'keeps the original level' do
    original_level = create(:level, from: 0, to: 29)
    user = create(:user, level: original_level)

    allow_any_instance_of(User).to receive(:total_points).and_return(20)

    expect { described_class.new.perform(user.id) }
      .to change { Notifications::NewLevel.count }.by(0)

    expect(user.reload.level).to eq(original_level)
  end

  it 'sets the new level' do
    original_level = create(:level, from: 0, to: 29)
    new_level = create(:level, from: 30, to: 59)
    user = create(:user, level: original_level)

    allow_any_instance_of(User).to receive(:total_points).and_return(40)

    expect { described_class.new.perform(user.id) }
      .to change { Notifications::NewLevel.count }.by(1)

    expect(user.reload.level).to eq(new_level)
  end
end
