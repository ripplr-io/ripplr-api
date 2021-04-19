require 'rails_helper'

RSpec.describe ContentSources::ScheduleWorker, type: :worker do
  subject { described_class.new.perform }

  it 'schedules UpdateWorkers for each ContentSource' do
    create_list(:content_source, 2)

    subject

    expect(ContentSources::UpdateWorker.jobs.size).to eq(2)
  end

  it 'skips disabled ContentSources' do
    create(:content_source)
    create(:content_source, disabled_at: Time.current)

    subject

    expect(ContentSources::UpdateWorker.jobs.size).to eq(1)
  end
end
