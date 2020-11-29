require 'rails_helper'

RSpec.describe Prizes::CreateService, type: :service do
  it 'creates the prize' do
    prize = build(:prize)

    expect { described_class.new(prize).save }
      .to change { Prize.count }.by(1)

    expect(Users::UpdateLevelWorker.jobs.size).to eq(1)
  end
end
