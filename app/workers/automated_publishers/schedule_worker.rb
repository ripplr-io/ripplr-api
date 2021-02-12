module AutomatedPublishers
  class ScheduleWorker < ApplicationWorker
    def perform
      AutomatedPublisher.all.each do |ap|
        AutomatedPublishers::UpdateWorker.perform_async(ap.id)
      end
    end
  end
end
