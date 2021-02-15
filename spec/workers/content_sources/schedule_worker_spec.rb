require 'rails_helper'

RSpec.describe ContentSources::ScheduleWorker, type: :worker do
  it 'schedules UpdateWorkers for each ContentSource' do
    create_list(:content_source, 2)

    described_class.new.perform

    expect(ContentSources::UpdateWorker.jobs.size).to eq(2)
  end
end
