module ContentSources
  class ScheduleWorker < ApplicationWorker
    def perform
      ContentSource.all.each do |ap|
        ContentSources::UpdateWorker.perform_async(ap.id)
      end
    end
  end
end
