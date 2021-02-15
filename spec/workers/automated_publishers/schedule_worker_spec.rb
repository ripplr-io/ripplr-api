require 'rails_helper'

RSpec.describe AutomatedPublishers::ScheduleWorker, type: :worker do
  it 'schedules UpdateWorkers for each AutomatedPublisher' do
    create_list(:automated_publisher, 2)

    described_class.new.perform

    expect(AutomatedPublishers::UpdateWorker.jobs.size).to eq(2)
  end
end
