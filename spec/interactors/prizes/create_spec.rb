require 'rails_helper'

RSpec.describe Prizes::Create, type: :interactor do
  it 'creates the prize' do
    prize = build(:prize)

    expect { described_class.call(resource: prize) }
      .to change { Prize.count }.by(1)

    expect(Users::UpdateLevelWorker.jobs.size).to eq(1)
  end
end
